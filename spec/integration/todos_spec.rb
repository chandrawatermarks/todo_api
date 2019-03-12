require 'swagger_helper'

describe 'Todos API' do

  path '/api/v1/todos' do

    post 'Creates a todo' do
      tags 'Todos'
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          status: { type: :string }
        },
        required: [ 'title']
      }

      response '201', 'todo created' do
        let(:todo) { { title: 'Dodo', status: 'Assigned' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:todo) { { title: 'foo' } }
        run_test!
      end
    end

    get 'Retrives All Todos' do
      tags 'Todos'
      consumes 'application/json'
      parameter name: :page, in: :query, :type => :string

      response '200', 'todos retrived' do
        let(:page) { 1 }
        run_test!
      end
    end
  end

  path '/api/v1/todos/{id}' do

    patch 'Update a todo' do
      tags 'Todos'
      consumes 'application/json'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          status: { type: :string }
        },
        required: [ 'title']
      }

      response '200', 'todo updated' do
        let(:id) { Todo.first.id }
        let(:todo) { { title: 'foo', status: "Finish" } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { Todo.first.id }
        let(:todo) { { status: 'foo' } }
        run_test!
      end
    end

    get 'Retrieves a todo' do
      tags 'Todos'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'Todo retrived' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            title: { type: :string },
            description: { type: :string },
            status: { type: :string }
          }

        let(:id) { Todo.create(title: 'foo', status: 'Assigned', description: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'todo not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Removes a todo' do
      tags 'Todos'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '204', 'Todo deleted' do
        let(:id) { Todo.create(title: 'foo', status: 'Assigned', description: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'todo not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

  end

  path '/api/v1/todos/{id}/recover' do
    get 'Recovers a todo' do
      tags 'Todos'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'Todo retrived' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            title: { type: :string },
            description: { type: :string },
            status: { type: :string }
          }

        let(:id) { Todo.create(title: 'foo', status: 'Assigned', description: 'http://example.com/avatar.jpg').id }
        run_test!
      end

      response '404', 'todo not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/todos/{id}/add_tags' do
    put 'Add Tag to a todo' do
      tags 'Todos'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :tag, in: :body, schema: {
        type: :object,
        properties: {
          tag_name: { type: :string }
        }
      }

      response '200', 'Tag Added' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            title: { type: :string },
            description: { type: :string },
            status: { type: :string }
          }

        # let(:id) { Todo.create(title: 'foo', status: 'Assigned', description: 'http://example.com/avatar.jpg').id }
        # let(:tag) { {tag: {name: "Test"}} }
        # run_test!
      end

      response '404', 'todo not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end