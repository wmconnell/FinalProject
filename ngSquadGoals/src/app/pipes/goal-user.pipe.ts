import { Pipe, PipeTransform } from '@angular/core';
import { Goal } from '../models/goal';
import { User } from '../models/user';

@Pipe({
  name: 'goalUser'
})
export class GoalUserPipe implements PipeTransform {

  transform(goals: Goal[], user: User| null = null): Goal[] {
    if(user === null){
      return goals;
    }
    const result:Goal[] = [];
    for(let goal of goals){
      console.log(goal.users.length);

      for (let member of goal.squads) {
        console.log(member.id);

        if(member.id === user.id){
            result.push(goal);
        }

      }
    }
    return result;
  }

}


