import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddSquadDialogComponent } from './add-squad-dialog.component';

describe('AddSquadDialogComponent', () => {
  let component: AddSquadDialogComponent;
  let fixture: ComponentFixture<AddSquadDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddSquadDialogComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddSquadDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
