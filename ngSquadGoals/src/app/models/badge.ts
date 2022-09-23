export class Badge {
  id: number = 0;
  name: string = '';
  description: string = '';
  users: any[] = [];
  squads: any[] = [];
  requirements: any[] = [];

  constructor(
    id: number = 0,
  name: string = '',
  description: string = '',
  users: any[] = [],
  squads: any[] = [],
  requirements: any[] = []
  ) {
  this.id = id;
  this.name = name;
  this.description = description;
  this.users = users;
  this.squads = squads;
  this.requirements = requirements;
  }
}
