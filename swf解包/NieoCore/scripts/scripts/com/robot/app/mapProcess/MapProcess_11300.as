package com.robot.app.mapProcess
{
   import com.robot.app.control.StarapprehendorderControler;
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
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class MapProcess_11300 extends BaseMapProcess
   {
      
      private var pets:Array = [3151,2705,3098,2861,2891,2692,2958,2966,2947];
      
      private var nowlevel:int;
      
      private var fightstate:Array;
      
      public function MapProcess_11300()
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
            while(_loc3_ < 9)
            {
               fightstate.push(KTool.getBit(param1[0],_loc3_ + 1));
               if(KTool.getBit(param1[0],_loc3_ + 1) == 1)
               {
                  _loc2_++;
               }
               _loc3_++;
            }
            nowlevel = int(_loc2_ / 3);
            conLevel["petmc"].gotoAndStop(nowlevel + 1);
            if(_loc2_ >= 9)
            {
               MapManager.changeMap(11301);
            }
            else
            {
               setTimeout(loadnewpet,300);
            }
         });
      }
      
      private function loadnewpet() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            conLevel["petmc"]["pet_" + _loc1_].visible = this.fightstate[this.nowlevel * 3 + _loc1_] == 0;
            conLevel["petb_" + _loc1_].visible = this.fightstate[this.nowlevel * 3 + _loc1_] == 0;
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
         idx = int(e.currentTarget.name.split("_")[1]);
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            var _loc3_:FightOverInfo = param1.dataObj as FightOverInfo;
            if(_loc3_.winnerID != MainManager.actorID)
            {
               leave();
            }
            else if(nowlevel * 3 + idx == 5)
            {
               StarapprehendorderControler.instance.overtask();
            }
         });
         FightManager.fightNoMapBoss("",this.nowlevel * 3 + idx + 7644);
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
         btnLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

