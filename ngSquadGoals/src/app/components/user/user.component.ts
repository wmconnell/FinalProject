import { User } from 'src/app/models/user';
import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {
users: User[] =[]
loggedIn: User = new User();
username: string | string = "admin";
  constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.route.params.subscribe({
      next: (params) =>{
        this.setUser(params['username'])
      }
    })

    if(this.auth.checkLogin() && this.auth.getUserName() != null){
      console.log(this.auth.checkLogin());
      console.log(this.auth.getUserName());
      console.log(this.loggedIn);
      console.log(this.username);

      this.auth.getUser(localStorage.getItem('username')!).subscribe({
        next: (user) =>{
          this.loggedIn = user

        },

        error: (err) =>{
          console.error(err)
          console.error("shits broke")
        }
      })
      console.log(this.loggedIn);
    }

    // let idStr = this.route.snapshot.paramMap.get('id');
    // console.log(idStr);

    // if(idStr){

    //   //got a todo ID, get and display todo
    //   let todoId = Number.parseInt(idStr);
    //     if(!isNaN(todoId)){
    //     this.userService.show(todoId).subscribe({

    //       next: (user) =>{
    //         console.log(user);

    //         this.loggedIn =user;
    //       },
    //       error: (err) =>{
    //         console.error('Error retriveing Todo:');
    //         console.error(err);
    //         this.router.navigateByUrl('noSuchTodo')
    //       }
    //     })
    //     }
    //     else{
    //       console.error('Invalid Todo Id: ' + idStr)
    //     }
    // }
    // this.load();
  }
  setUser(username: string){
    this.auth.getUser(username).subscribe({
      next:(user) =>{
        this.loggedIn =user;
      }
    });
  }
load(){
  if(this.loggedIn){

    this.auth.getUser(this.loggedIn.username).subscribe({
      next: (user) =>{
        this.loggedIn =user
      },
      error: (err) =>{
        console.error('error getting credentials');
        console.error(err);
      }
    })
  }
  // this.userService.show(this.loggedIn.id).subscribe({
  //   next: (user) =>{
  //     this.loggedIn =user
  //   },
  //   error: (problem) =>{
  //     console.error("error loading users")
  //     console.error(problem)
  //   }


  // })
}

}
