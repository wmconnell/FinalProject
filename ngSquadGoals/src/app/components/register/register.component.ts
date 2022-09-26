import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  newUser = new User();
  usernameIsUnique: boolean = true;

  constructor(private auth: AuthService, private router: Router) { }

  ngOnInit(): void {
  }

  register(user: User): void {
    console.log('Registering user:');
    console.log(user);
    this.auth.checkUsernameUnique(user.username).subscribe({
      next: (isUnique) => {
        if(isUnique) {
          this.usernameIsUnique = true;
          this.auth.register(user).subscribe({
            next: (registeredUser) => {
              this.auth.login(user.username, user.password).subscribe({
                next: (loggedInUser) => {
                  this.router.navigateByUrl('user');
                },
                error: (problem) => {
                  console.error('RegisterComponent.register(): Error logging in user:');
                  console.error(problem);
                }
              });
            },
            error: (fail) => {
              console.error('RegisterComponent.register(): Error registering account');
              console.error(fail);
            }
          });
        } else {
          this.usernameIsUnique = false;
        }
      }
    });
  }

}
