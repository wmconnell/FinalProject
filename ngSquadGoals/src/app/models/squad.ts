import { User } from "./user";

export class Squad {
  id: number = 0;
  name: string = '';
  bio: string = '';
  active: boolean = false;
  createDate: Date | null = null;
  users: any[] = [];
  goals: any[] = [];
  tasks: any[] = [];
  tags: any[] = [];
  badges: any[] = [];
  squadMessages: any[] = [];
  profilePic: any = null;
  leader: User;
  leaderName: string = "";
  numMembers: number | null = null;

  constructor(
    id: number = 0,
    name: string = '',
    bio: string = '',
    active: boolean = false,
    createDate: Date | null = null,
    users: any[] = [],
    goals: any[] = [],
    tasks: any[] = [],
    tags: any[] = [],
    badges: any[] = [],
    squadMessages: any[] = [],
    profilePic: any = null,
    leader: User = new User()
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
  this.leader = leader;
  }
}
