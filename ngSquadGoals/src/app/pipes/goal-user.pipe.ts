import { Pipe, PipeTransform } from '@angular/core';
import { Goal } from '../models/goal';
import { User } from '../models/user';
import { UserService } from 'src/app/services/user.service';

@Pipe({
  name: 'goalUser'
})
export class GoalUserPipe implements PipeTransform {

  constructor(private userService: UserService) {}

  transform(goals: Goal[], user: User| null = null): Goal[] {
    if(user === null){
      return goals;
    }
    const goalList:Goal[] = [];
    if (goals != null && goals !== undefined && goals.length > 0) {
    for(let goal of goals){
      console.log(goal.users.length);

      for (let squad of goal.squads) {
        console.log("Squad ID: " + squad.id);

        this.userService.getUsersBySquad(squad.id).subscribe({
          next: (result) => {
            for (let member of result) {
              if(member.id === user.id){
                  goalList.push(goal);
              }
            }
          },
            error: (nojoy) => {
              console.error('error retrieving squads:');
              console.error(nojoy);
            }
          });

      }
    }
  }
    return goalList;
  }

}


