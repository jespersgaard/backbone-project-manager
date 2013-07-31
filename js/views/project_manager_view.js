var project_mgr = project_mgr || {};
// The Application
// ---------------
// Our overall **AppView** is the top-level piece of UI.
project_mgr.Project_Manager_View = Backbone.View.extend({
    // Instead of generating a new element, bind to the existing skeleton of
    // the app already present in the HTML.
    el: '#tabs_log',
    // Our template for the line of statistics at the bottom of the app.
    // 
//    statsTemplate: _.template( $('#stats-template').html() ),
    // 
    // At initialization we bind to the relevant events on the `Entries`
    // collection, when items are added or changed.
    
    // Delegated events for creating new items, and clearing completed ones.
    events: {
        'keypress #new-todo': 'createOnEnter',
        'click #clear-completed': 'clearCompleted',
        'click #toggle-all': 'toggleAllComplete'
    },    
    
    
    initialize: function() {        
//        this.allCheckbox = this.$('#toggle-all')[0];
//        this.$input = this.$('#new-todo');
//        this.$footer = this.$('#footer');
//        this.$main = this.$('#main');
//        this.listenTo(project_mgr.Entries, 'add', this.addOne);
//        this.listenTo(project_mgr.Entries, 'reset', this.addAll);
//        this.listenTo(project_mgr.Entries, 'change:completed', this.filterOne);
//        this.listenTo(project_mgr.Entries,'filter', this.filterAll);
//        this.listenTo(project_mgr.Entries, 'all', this.render);
        project_mgr.Entries.fetch();        
    },
            
            
    // Rerendering the app just means refreshing the statistics -- the rest
    // of the app doesn't change.
    render: function() {
//        var completed = project_mgr.Entries.completed().length;
//        var remaining = project_mgr.Entries.remaining().length;
//        if ( project_mgr.Entries.length ) {
//            this.$main.show();
//            this.$footer.show();
//            this.$footer.html(this.statsTemplate({
//            completed: completed,
//            remaining: remaining
//            }));
//            
//            this.$('#filters li a')
//                .removeClass('selected')
//                .filter('[href="#/' + ( project_mgr.EntryFilter || '' ) + '"]')
//                .addClass('selected');
//        } else {
//            this.$main.hide();
//            this.$footer.hide();
//        }
//        this.allCheckbox.checked = !remaining;
    },
            
            
            
    // Add a single todo item to the list by creating a view for it, and
    // appending its element to the `<ul>`.
    addOne: function( todo ) {
        var view = new project_mgr.EntryView({ model: todo });
        $('#tabs_log').append( view.render().el );
    },
    // Add all items in the **Todos** collection at once.
    addAll: function() {
        this.$('#tabs_log').html('');
        project_mgr.Entries.each(this.addOne, this);
    },
            
            
    filterOne : function (todo) {
        entry.trigger('visible');
    },

    filterAll : function () {
        project_mgr.Entries.each(this.filterOne, this);
    },
    // Generate the attributes for a new todo item.
    newAttributes: function() {
        return {
        title: this.$input.val().trim(),
        order: project_mgr.Entries.nextOrder(),
        completed: false
        };
    },
    // If you hit return in the main input field, create new Todo model,
    // persisting it to localStorage.
    createOnEnter: function( event ) {
    if ( event.which !== ENTER_KEY || !this.$input.val().trim() ) {
    return;
    }
    project_mgr.Entries.create( this.newAttributes() );
    this.$input.val('');
    },
    // New
    // Clear all completed todo items, destroying their models.
    clearCompleted: function() {
    _.invoke(project_mgr.Entries.completed(), 'destroy');
    return false;
    },
    // New
    toggleAllComplete: function() {
        var completed = this.allCheckbox.checked;
        project_mgr.Entries.each(function( entry ) {
            entry.save({
            'completed': completed
        });
        });
    }            
            
            
    
    
});
