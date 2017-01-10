@Tasks = React.createClass
  getInitialState: ->
    tasks: @props.data

  getDefaultProps: ->
    tasks: []

  addTask: (task) ->
    tasks = React.addons.update(@state.tasks, { $push: [task] })
    @setState tasks: tasks

  deleteTask: (task) ->
    index = @state.tasks.indexOf task
    tasks = React.addons.update(@state.tasks, { $splice: [[index, 1]] })
    @replaceState tasks: tasks

  updateTask: (task, data) ->
    index = @state.tasks.indexOf task
    tasks = React.addons.update(@state.tasks, { $splice: [[index, 1, data]] })
    @replaceState tasks: tasks

  render: ->
    React.DOM.div
      className: 'tasks'
      React.DOM.h2
        className: 'title'
        'Tasks'
      React.createElement TaskForm, handleNewTask: @addTask
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Description'
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Status'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for task in @state.tasks
            React.createElement Task, key: task.id, task: task, handleDeleteTask: @deleteTask, handleEditTask: @updateTask