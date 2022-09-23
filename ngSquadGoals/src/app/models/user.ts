export class User {
id: number = 0;
username: string = '';
password: string = '';
email: string = '';
firstName: string = '';
lastName: string = '';
role: string = '';
bio: string = '';
active: boolean = false;
createDate: Date| null; //dates not initialized
reviews: any[] = [];
squads: any[] = [];
goals: any[] = [];
tasks: any[] = [];
badges: any[] = [];
squadMessages: any[] = [];
tags: any[] = [];
profilePic: any = null;
goalsCreated: any[] = [];


constructor(
id: number = 0,
username: string = '',
password: string = '',
email: string = '',
firstName: string = '',
lastName: string = '',
role: string = '',
bio: string = '',
active: boolean = false,
createDate: Date| null = null,
reviews: any[] = [],
squads: any[] = [],
goals: any[] = [],
tasks: any[] = [],
badges: any[] = [],
squadMessages: any[] = [],
tags: any[] = [],
profilePic: any = null,
goalsCreated: any[] = []
) {
  this.id = id;
  this.username = username;
  this.password = password;
  this.email = email;
  this.firstName = firstName;
  this.lastName = lastName;
  this.role = role;
  this.bio = bio;
  this.active = active;
  this.createDate = createDate;
  this.reviews = reviews;
  this.squads = squads;
  this.goals = goals;
  this.tasks = tasks;
  this.badges = badges;
  this.squadMessages = squadMessages;
  this.tags = tags;
  this.profilePic = profilePic;
  this.goalsCreated = goalsCreated;
}

}
