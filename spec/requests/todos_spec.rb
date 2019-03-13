require 'rails_helper'

RSpec.describe 'Todo API', type: :request do

  let!(:todos) {create_list(:todo, 10)}
  let(:todo_id) {todos.first.id}

  # Test suite for GET /api/v1/todos

  describe 'GET /api/v1/todos' do

    before {get '/api/v1/todos'} # make HTTP get request before each example

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  # Test suite for GET /api/v1/todos/:id

  describe 'GET /api/v1/todos/:id' do
    before {get "/api/v1/todos/#{todo_id}"}

    context 'when the todo exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json["todo"]["title"]).to eq(todos.first.title) 
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the todo does not exists' do
      let(:todo_id) {100}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /api/v1/todos

  describe 'POST /api/v1/todos' do
    let(:valid_attributes) {{todo: {title: 'Learn react', status: "Assigned"}}}

    context 'when the request is valid' do
      before {post '/api/v1/todos', valid_attributes}

      it 'creates a todo' do
        expect(json['todo']['title']).to eq('Learn react')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is not valid' do
      before {post '/api/v1/todos', {todo: {title: ''}}}

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /api/v1/todos/:todo_id

  describe 'PUT /api/v1/todos/:todo_id' do
    let(:valid_attributes) {{todo: {title: 'Learn react and angular'}}}

    context 'when the record exists' do
      before {put "/api/v1/todos/#{todo_id}", valid_attributes}

      it 'update the todo' do
        expect(json["todo"]["title"]).to eq('Learn react and angular')
      end

      it 'returns the status code 200' do
        expect(response).to have_http_status(200)
      end
    end

  end

  # Test suite for PATCH /api/v1/todos/:todo_id/change_status

  describe 'PUT /api/v1/todos/:todo_id/change_status' do
    let(:valid_attributes) {{todo: {status: 'Finished'}}}

    context 'when requested to update with valid status' do
      before {put "/api/v1/todos/#{todo_id}/change_status", valid_attributes}

      it 'update the todo' do
        expect(json['todo']['status']).to eq("Finished")
      end

      it 'returns the status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when requested to update with invalid status' do
      before {put "/api/v1/todos/#{todo_id}/change_status", {todo: {status: 'something random'}}}

      it 'returns the status code 422' do
        expect(response).to have_http_status(422)
      end
    end

  end

  # Test suite for PUT /api/v1/todos/:todo_id/add_tags

  describe 'PUT /api/v1/todos/:todo_id/add_tags' do

    context 'when requested with tag' do
      let(:tag_name) {Faker::Lorem.word}
      let(:valid_attributes) {{tag: {name: tag_name}}}
      before {put "/api/v1/todos/#{todo_id}/add_tags", valid_attributes}

      it 'assign tag to todo' do
        expect(Todo.find(todo_id).tags.last.name).to eq(tag_name)
      end

      it 'returns the status code 201' do
        expect(response).to have_http_status(201)
      end
    end

  end

  # Test suite for DELETE /api/v1/todos/:todo_id

  describe 'DELETE /api/v1/todos/:todo_id' do
    before {delete "/api/v1/todos/#{todo_id}"}

    it 'return the status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # Test suite for Restore /api/v1/todos/:todo_id/restore

  describe 'GET /api/v1/todos/:todo_id/recover' do
    before {delete "/api/v1/todos/#{todo_id}"}
    before {get "/api/v1/todos/#{todo_id}/recover"}

    it 'return the status code 204' do
      expect(response).to have_http_status(200)
    end
  end
end