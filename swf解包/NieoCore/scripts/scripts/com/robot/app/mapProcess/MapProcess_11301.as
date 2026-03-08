package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_11301 extends BaseMapProcess
   {
      
      private var pets:Array = [3164,3145,3184];
      
      private var nowlevel:int;
      
      private var fightstate:Array;
      
      public function MapProcess_11301()
      {
         super();
      }
      
      override protected function init() : void
      {
         var k:int;
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         LevelManager.iconLevel.visible = false;
         btnLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         k = 0;
         while(k < 3)
         {
            conLevel["petb_" + k].addEventListener(MouseEvent.CLICK,this.fight);
            k++;
         }
         KTool.getMultiValue([13926],function(param1:Array):void
         {
            var _loc2_:int = 0;
            nowlevel = 0;
            fightstate = [];
            var _loc3_:int = 0;
            while(_loc3_ < 3)
            {
               fightstate.push(KTool.getBit(param1[0],_loc3_ + 10));
               _loc3_++;
            }
            loadnewpet();
         });
      }
      
      private function loadnewpet() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            conLevel["pet_" + _loc1_].visible = this.fightstate[_loc1_] == 0;
            conLevel["petb_" + _loc1_].visible = this.fightstate[_loc1_] == 0;
            _loc1_++;
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "bag":
               PetBagControllerNew.showByBuffer();
               break;
            case "cure":
               PetManager.cureAllFree();
               break;
            case "leave":
               MapManager.changeMap(1202);
         }
      }
      
      private function leave() : void
      {
         MapManager.changeMap(1202);
         ModuleManager.showAppModule("StrongDignifiedPanel");
      }
      
      private function fight(param1:MouseEvent) : void
      {
         var idx:int = 0;
         var e:MouseEvent = param1;
         if(this.fightstate == null)
         {
            return;
         }
         idx = int(e.currentTarget.name.split("_")[1]);
         if(idx == 2 && (this.fightstate[0] != 1 || this.fightstate[1] != 1))
         {
            Alarm.show("在未击败全部手下之前，你无法挑战最强大的王者！");
            return;
         }
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            var _loc3_:FightOverInfo = param1.dataObj as FightOverInfo;
            if(_loc3_.winnerID != MainManager.actorID)
            {
               leave();
            }
            else if(idx == 2)
            {
               Alarm.show("恭喜你击败了最强的王者！");
               MapManager.changeMap(1202);
               ModuleManager.showAppModule("ArenaPanel");
            }
         });
         FightManager.fightNoMapBoss("",7653 + idx);
      }
      
      private function removeAllPet() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            DisplayUtil.removeAllChild(conLevel["pet_" + _loc1_]);
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            conLevel["petb_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.fight);
            _loc1_++;
         }
         KTool.showMapAllPlayerAndMonster();
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         this.removeAllPet();
         btnLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

