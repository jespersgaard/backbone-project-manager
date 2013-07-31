
// js/collections/entries.js
var project_mgr = project_mgr || {};
// Entry Collection
// ---------------
// The collection of entries is backed by *localStorage* instead of a remote
// server.
var Entries = Backbone.Collection.extend({
    // Reference to this collection's model.
    model: project_mgr.Entry,
    // Save all of the entries under the `"todos-backbone"` namespace.
    // Note that you will need to have the Backbone localStorage plug-in
    // loaded inside your page in order for this to work. If testing
    // in the console without this present, comment out the next line
    // to avoid running into an exception.
    // 
//    localStorage: new Backbone.LocalStorage('entries-backbone'),
//    
    // Filter down the list of all todo items that are finished.
    completed: function() {
        return this.filter(function( entry ) {
        return entry.get('completed');
        });
    },
    // Filter down the list to only todo items that are still not finished.
    remaining: function() {
        // apply allows us to define the context of this within our function scope
        return this.without.apply( this, this.completed() );
    },
    // We keep the Todos in sequential order, despite being saved by unordered
    // GUID in the database. This generates the next order number for new items.
    nextOrder: function() {
        if ( !this.length ) {
        return 1;
    }
    return this.last().get('order') + 1;
    },
    // Todos are sorted by their original insertion order.

    comparator: function( entry ) {
        return entry.get('order');
    }
});
// Create our global collection of **Entries**.
//project_mgr.Entries = new Entries();