@Task = React.createClass
  getInitialState: ->
    edit: false
    status: @props.task.status

  toggle: ->
    @setState status: !@refs.status.checked

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/tasks/#{ @props.task.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteTask @props.task

  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: @refs.title.value
      description:@refs.description.value
      status: @refs.status.checked
    $.ajax
      method: 'PUT'
      url: "/tasks/#{ @props.task.id }"
      dataType: 'JSON'
      data:
        task: data
      success: (data) =>
        @setState edit: false
        @props.handleEditTask @props.task, data

  taskRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.task.title
      React.DOM.td null, @props.task.description
      React.DOM.td null, @props.task.created_at
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'checkbox'
          checked: @status
          disabled: true
          ref: 'status'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-warning'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'

  taskForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.task.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.task.description
          ref: 'description'
      React.DOM.td null, @props.task.created_at
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'checkbox'
          checked: @status
          onChange: @toggle
          ref: 'status'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-success'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'

  render: ->
    if @state.edit
      @taskForm()
    else
      @taskRow()