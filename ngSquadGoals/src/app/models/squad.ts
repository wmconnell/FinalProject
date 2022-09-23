export class Squad {
  id: number = 0;
  name: string = '';
  bio: string = '';
  active: boolean = false;
  createDate: Date = ;
  users: any[] = [];
  goals: any[] = [];
  tasks: any[] = [];
  tags: any[] = [];
  badges: any[] = [];
  squadMessages: any[] = [];
  profilePic: any = null;

  constructor(
    id: number = 0,
  name: string = '',
  bio: string = '',
  active: boolean = false,
  createDate: Date = ,
  users: any[] = [],
  goals: any[] = [],
  tasks: any[] = [],
  tags: any[] = [],
  badges: any[] = [],
  squadMessages: any[] = [],
  profilePic: any = null
  ) {
  this.id = id;
  this.name = name;
  this.bio = bio;
  this.active = active;
  this.createDate = createDate;
  this.users = users;
  this.goals = goals;
  this.tasks = tasks;
  this.tags = tags;
  this.badges = badges;
  this.squadMessages = squadMessages;
  this.profilePic = profilePic;
  }
}
