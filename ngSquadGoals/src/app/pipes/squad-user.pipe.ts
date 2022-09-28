import { Pipe, PipeTransform } from '@angular/core';
import { Squad } from '../models/squad';
import { User } from '../models/user';

@Pipe({
  name: 'squadUser'
})
export class SquadUserPipe implements PipeTransform {

  transform(squads: Squad[], user: User| null = null): Squad[] {
    if(user === null){
      return squads;
    }
    const squadList:Squad[] = [];
    if (squads != null && squads !== undefined && squads.length > 0) {

    for(let squad of squads){
      console.log(squad.users.length);

      for (let member of squad.users) {
        console.log(member.id);

        if(member.id === user.id){
            squadList.push(squad);
        }

      }
    }
  }
  return squadList;

}

}
