class Api::BooksController < ApplicationController
  def index
    @books = Book.all
    render json: @books
  end

  def show
    @book = Book.find_by(id: params[:id])

    if @book
      render json: @book, status: :ok
    else
      render json: { message: 'Book not found' }, status: :bad_request
    end
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: api_book_url(@book)
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find_by(id: params[:id])

    if @book
      @book.reservations.each do |reservation|
        reservation.books.delete(@book)
        reservation.destroy if reservation.books.empty?
      end
      @book.destroy
      render json: { message: 'Book Was deleted successfully' }, status: :ok
    else
      render json: { message: 'Book not found' }, status: :not_found
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :cover_photo, :author, :category, :info, :publisher, :publish_date)
  end
end
