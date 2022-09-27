import { Pipe, PipeTransform } from '@angular/core';
import { Squad } from '../models/squad';
import { User } from '../models/user';

@Pipe({
  name: 'squadUser'
})
export class SquadUserPipe implements PipeTransform {

  transform(squads: Squad[], id: number| null = null): Squad[] {
    if(id === null){
      return squads;
    }
    const result:Squad[] = [];
    for(let squad of squads){
      for (let member of squad.users) {
        console.log(member.id);


        if(member.id === id){
          result.push(member);
        }
      }
    }
    return result;
  }

}


