import { Pipe, PipeTransform } from '@angular/core';
import { Goal } from '../models/goal';

@Pipe({
  name: 'activeGoals'
})
export class ActiveGoalsPipe implements PipeTransform {

  transform(goals: Goal[], status: boolean = true): Goal[] {
    if(status === false){
      return goals;
    }
    const result:Goal[] = [];
    for(let goal of goals){
      if(goal.active === status){
        result.push(goal);
      }
    }
    return result;
  }

}
