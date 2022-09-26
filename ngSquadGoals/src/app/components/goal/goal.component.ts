import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { User } from 'src/app/models/user';
import { Goal } from 'src/app/models/goal';
import { AuthService } from 'src/app/services/auth.service';
import { GoalService } from 'src/app/services/goal.service';
import { TaskService } from 'src/app/services/task.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-goal',
  templateUrl: './goal.component.html',
  styleUrls: ['./goal.component.css']
})
export class GoalComponent implements OnInit {


  constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute, private goalService: GoalService, private taskService: TaskService) { }

  loggedIn: User = new User();

  goals: Goal[] = [];
  newGoal: Goal = new Goal();

  ngOnInit(): void {
    this.load();
  }

  isLoggedIn(){
    if(this.auth.checkLogin()){
      return true
    }
    else{
      return false;
    }
  }

  load = (): void => {
    this.auth.getLoggedInUser().subscribe(
      {
      next: (user) => {
        this.loggedIn = user;
        // console.log("Successfully retrieved user id " + user.id);
      },
      error: (err) => {
        console.error("Unable to retrieve user: " + err);
      }
    }
    );
  }

  createGoal(goal: Goal): void {

    this.goalService.createGoal(goal).subscribe({
      next: (result) => {
        this.newGoal = new Goal();
        this.load();
      },
      error: (nojoy) => {
        console.error('error creating pokemon:');
        console.error(nojoy);
      },
    });
  }

}
