import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PublicsquadComponent } from './publicsquad.component';

describe('PublicsquadComponent', () => {
  let component: PublicsquadComponent;
  let fixture: ComponentFixture<PublicsquadComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PublicsquadComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PublicsquadComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
