import { UserService } from './services/user.service';
import {HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { FormsModule } from '@angular/forms';
import { RegisterComponent } from './components/register/register.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { AuthService } from './services/auth.service';
import { AboutComponent } from './components/about/about.component';
import { UserComponent } from './components/user/user.component';
import { BadgeComponent } from './components/badge/badge.component';
import { GoalComponent } from './components/goal/goal.component';
import { ImageComponent } from './components/image/image.component';
import { ReviewComponent } from './components/review/review.component';
import { SquadComponent } from './components/squad/squad.component';
import { TagComponent } from './components/tag/tag.component';
import { TaskComponent } from './components/task/task.component';
import { ActivePipe } from './pipes/active.pipe';
import { ActiveGoalsPipe } from './pipes/active-goals.pipe';
import { SquadUserPipe } from './pipes/squad-user.pipe';

@NgModule({
  declarations: [
    AppComponent,
    NavBarComponent,
    HomeComponent,
    LoginComponent,
    LogoutComponent,
    RegisterComponent,
    NotFoundComponent,
    AboutComponent,
    UserComponent,
    BadgeComponent,
    GoalComponent,
    ImageComponent,
    ReviewComponent,
    SquadComponent,
    TagComponent,
    TaskComponent,
    ActivePipe,
    ActiveGoalsPipe,
    SquadUserPipe
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule
  ],

    providers:  [
    AuthService,
    UserService

    ],
  bootstrap: [AppComponent]
})
export class AppModule { }
