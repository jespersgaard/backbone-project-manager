var project_mgr = project_mgr || {};


project_mgr.Project = Backbone.Model.extend({

    urlRoot: "api/index.php/projects",
    url: function() {
        
        var base = this.urlRoot || (this.collection && this.collection.url) || "/";

        console.log("in project model - url:" + base);
        return base;
    },
    defaults: {
    project_id: '',
    project_name: '',
    logs: null,
    bugs: null,
    specs: null
    },
    initialize: function (){
        if(this.get('project_id').length != 0) {
            this.attachProjectCollections();
        }
    },
    attachProjectCollections: function() {
            this.logs = new project_mgr.LogCollection();
            this.logs.urlRoot = "api/index.php/logs/" + this.get('project_id');
            this.bugs = new project_mgr.BugCollection();
            this.bugs.urlRoot = "api/index.php/bugs/" + this.get('project_id');
            this.specs = new project_mgr.SpecCollection();
            this.specs.urlRoot = "api/index.php/specs/" + this.get('project_id');
    }
    
});


// The collection of projects
project_mgr.ProjectCollection = Backbone.Collection.extend({
    // Reference to this collection's model.
    model: project_mgr.Project,
    
    url: "api/index.php/projects"
});

//Log Model
project_mgr.Log = Backbone.Model.extend({

    urlRoot: "api/index.php/logs",

    url: function() {
        var base = this.urlRoot || (this.collection && this.collection.url) || "/";
        
        if (this.isNew()){
            return base;
        }
        
        return base + "/" + encodeURIComponent(this.get('id'));

    },
            
    defaults: {
    project_id: '',
//    id: '', //this was causing isNew to return false results. id already exists in the model
    date: '',
    entry_text: ''
    },

    logEdited: function() {
        this.save({
           entry_text: this.get('entry_text') 
        });
    }

});


// The collection of entries is backed by *localStorage* instead of a remote
// server.
project_mgr.LogCollection = Backbone.Collection.extend({
    model: project_mgr.Log,

    url: function() {
        var base = this.urlRoot || (this.collection && this.collection.url) || "/";
        return base;
    }

});

//Bug Model
project_mgr.Bug = Backbone.Model.extend({
            
    urlRoot: "api/index.php/bugs",

    defaults: {
    project_id: '',
    date_opened: '',
    date_closed: '',
    notes: '',
    entry: '',
    open: '1'
    },
            
    url: function() {
        var base = this.urlRoot || (this.collection && this.collection.url) || "/";
        
        if (this.isNew()) return base;
 
        return base + "/" + encodeURIComponent(this.get('id'));

    }


});

project_mgr.BugCollection = Backbone.Collection.extend({
    model: project_mgr.Bug,

    url: function() {
        var base = this.urlRoot || (this.collection && this.collection.url) || "/";
        return base;
    }

});


//Bug Model
project_mgr.Spec = Backbone.Model.extend({
    urlRoot: "api/index.php/specs",
            
    defaults: {
    project_id: '',
    open: '1',
    notes: '',
    spec: ''
    },
    url: function() {
        var base = this.urlRoot || (this.collection && this.collection.url) || "/";
        if (this.isNew()) return base;
 
        return base + "/" + encodeURIComponent(this.get('id'));

    }

});

project_mgr.SpecCollection = Backbone.Collection.extend({
    model: project_mgr.Spec,

    url: function() {
        var base = this.urlRoot || (this.collection && this.collection.url) || "/";
        return base;
    }

});