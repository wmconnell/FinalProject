import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RemoveUserFromSquadDialogComponent } from './remove-user-from-squad-dialog.component';

describe('RemoveUserFromSquadDialogComponent', () => {
  let component: RemoveUserFromSquadDialogComponent;
  let fixture: ComponentFixture<RemoveUserFromSquadDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RemoveUserFromSquadDialogComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RemoveUserFromSquadDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
