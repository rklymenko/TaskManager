@TaskForm = React.createClass
  getInitialState: ->
    title: ''
    description: ''
    status: 0
    toggled: false

  valid: ->
    @state.title && @state.description

  toggle: ->
    @setState toggled: !@state.status

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/tasks', { task: @state }, (data) =>
      @props.handleNewTask data
      @setState @getInitialState()
    , 'JSON'

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Description'
          name: 'description'
          value: @state.description
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'checkbox'
          className: 'form-control'
          placeholder: 'Status'
          name: 'status'
          checked: @toggled
          onChange: @toggle
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create task'