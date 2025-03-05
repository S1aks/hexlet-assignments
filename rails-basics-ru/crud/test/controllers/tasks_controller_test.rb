require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test 'get_index' do
    get tasks_url

    assert_response :success
  end

  test 'get_new' do
    get new_task_url

    assert_response :success
  end

  test 'create_task' do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { name: 'Name task', description: 'Description Task', status: 'Task status', creator: 'Hugo Boss', performer: 'Maria Luiza', completed: false } }
    end

    assert_redirected_to task_url(Task.last)
  end

  test 'show_task' do
    get task_url(@task)

    assert_response :success
  end

  test 'get_edit' do
    get edit_task_url(@task)

    assert_response :success
  end

  test 'update_task' do
    patch task_url(@task), params: { task: { name: 'Updated name', description: 'This task has been updated.' } }
    assert_redirected_to task_url(@task)
    @task.reload
    assert_equal 'Updated name', @task.name
    assert_equal 'This task has been updated.', @task.description
  end

  test 'destroy_task' do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
