class NotesController < ApplicationController
    
    def index 
        notes = Note.all 
        render json: { success: true, notes: notes, status: 200 }
    end
    
    def create 
        note = @current_user.notes.new(title: params[:title], content: params[:content])

        if note.save
            render json: { success: true, note: note, status: 201 }
        else
            render json: { errors: note.errors.full_messages, status: 400 }
        end
    end

    def show
        note = Note.find(params[:id])
        render json: { success: true, note: note, status: 200 }
    end
    
    def update
        note = Note.find(params[:id])
        if note.update(title: params[:title], content: params[:content])
          render json: { success: true, note: note, status: 200 }
        else
          render json: { errors: note.errors.full_messages, status: 400 }
        end
    end

    def destroy
        note = Note.find(params[:id])

        note.destroy
        render json: { success: true, message: "Note deleted successfully", status: 200 }
    end

end
