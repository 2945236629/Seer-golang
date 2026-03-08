package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.MapStoryManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_1717 extends BaseMapProcess
   {
      
      private var isGetBtn2:Boolean = true;
      
      private var isGetBtn3:Boolean = true;
      
      public function MapProcess_1717()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.getMultiValue([124338],function(param1:Array):void
         {
            var _loc2_:int = int(param1[0]);
            isGetBtn2 = KTool.getBit(_loc2_,19) == 1;
            isGetBtn3 = KTool.getBit(_loc2_,20) == 1;
            conLevel["btn_3"].visible = !isGetBtn3;
            conLevel["btn_2"].visible = !isGetBtn2;
         });
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         animatorLevel["four_1"].visible = true;
         animatorLevel["five_1"].visible = true;
         animatorLevel["four_2"].visible = false;
         animatorLevel["five_2"].visible = false;
         animatorLevel["transition"].visible = false;
         animatorLevel["head"].visible = false;
         EventManager.addEventListener("MapProcess_1717.AfterFight",this.AfterFight);
      }
      
      private function AfterFight(param1:*) : void
      {
         animatorLevel["four_1"].visible = false;
         animatorLevel["five_1"].visible = false;
         animatorLevel["four_2"].visible = true;
         animatorLevel["five_2"].visible = true;
         animatorLevel["transition"].visible = false;
         animatorLevel["head"].visible = true;
      }
      
      override public function destroy() : void
      {
         EventManager.removeEventListener("MapProcess_1717.AfterFight",this.AfterFight);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:*) : void
      {
         var e:* = param1;
         var btnName:String = e.target.name;
         var index:int = int(btnName.split("_")[1]);
         switch(btnName)
         {
            case "btn_1":
               if(animatorLevel["four_1"].visible)
               {
                  animatorLevel["head"].visible = true;
                  animatorLevel["head"].gotoAndPlay(1);
                  MapStoryManager.dialog(172,19,function(param1:int):void
                  {
                  });
                  animatorLevel["four_1"].visible = false;
                  animatorLevel["five_1"].visible = false;
                  animatorLevel["transition"].visible = true;
                  animatorLevel["transition"]["F1"].gotoAndPlay(1);
                  animatorLevel["transition"]["F2"].gotoAndPlay(1);
                  animatorLevel["four_2"].visible = true;
                  animatorLevel["five_2"].visible = true;
                  conLevel["btn_1"].visible = false;
               }
               break;
            case "btn_2":
               if(this.isGetBtn2)
               {
                  return;
               }
               this.isGetBtn2 = true;
               MapStoryManager.dialog(172,16,function(param1:int):void
               {
                  SocketConnection.send(41900,[103,19]);
               });
               conLevel["btn_3"].visible = !this.isGetBtn3;
               conLevel["btn_2"].visible = !this.isGetBtn2;
               break;
            case "btn_3":
               if(this.isGetBtn3)
               {
                  return;
               }
               this.isGetBtn3 = true;
               MapStoryManager.dialog(172,17,function(param1:int):void
               {
                  SocketConnection.send(41900,[103,20]);
               });
               conLevel["btn_3"].visible = !this.isGetBtn3;
               conLevel["btn_2"].visible = !this.isGetBtn2;
               break;
            case "btn_4":
               if(animatorLevel["four_1"].visible)
               {
                  MapStoryManager.dialog(172,18,function(param1:int):void
                  {
                  });
                  break;
               }
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                  EventManager.dispatchEvent(new Event("MapProcess_1717.AfterFight"));
               });
               FightManager.fightWithBoss("",0);
               break;
            case "btn_5":
               if(animatorLevel["five_1"].visible)
               {
                  MapStoryManager.dialog(172,18,function(param1:int):void
                  {
                  });
                  break;
               }
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                  EventManager.dispatchEvent(new Event("MapProcess_1717.AfterFight"));
               });
               FightManager.fightWithBoss("",0);
         }
      }
   }
}

