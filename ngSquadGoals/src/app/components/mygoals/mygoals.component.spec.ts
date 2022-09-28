import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MygoalsComponent } from './mygoals.component';

describe('MygoalsComponent', () => {
  let component: MygoalsComponent;
  let fixture: ComponentFixture<MygoalsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MygoalsComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MygoalsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
