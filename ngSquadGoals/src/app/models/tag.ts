export class Tag {
  id: number = 0;
  name: string = '';
  description: string = '';
  users: any[] = [];
  squads: any[] = [];
  goals: any[] = [];

  constructor(
    id: number = 0,
  name: string = '',
  description: string = '',
  users: any[] = [],
  squads: any[] = [],
  goals: any[] = []
  ) {
  this.id = id;
  this.name = name;
  this.description = description;
  this.users = users;
  this.squads = squads;
  this.goals = goals;
  }
}
