import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  loginUser = new User();
    constructor(private auth: AuthService, private router: Router) { }

    ngOnInit(): void {
    }
  login(user: User){
    console.log(user);
    this.auth.login(user.username,user.password).subscribe({
      next: (user) =>{
        this.router.navigateByUrl('/todo');

      },
      error: (err) => {
        console.error("cant log in user: " + err)
      }
    })

  }
}
