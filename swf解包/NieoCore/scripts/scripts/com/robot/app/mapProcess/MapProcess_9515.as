package com.robot.app.mapProcess
{
   import com.robot.app.fightNote.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import gs.*;
   
   public class MapProcess_9515 extends BaseMapProcess
   {
      
      public function MapProcess_9515()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.initShip();
         conLevel["task836mc"].visible = false;
         var _loc1_:Date = new Date();
         var _loc2_:int = int(_loc1_.getHours());
         if(_loc2_ >= 18)
         {
            if(Boolean(animatorLevel["task_819_2"]))
            {
               animatorLevel["task_819_2"].mouseEnabled = true;
               animatorLevel["task_819_2"].buttonMode = true;
               animatorLevel["task_819_2"].addEventListener(MouseEvent.CLICK,this.onTask819Click);
               animatorLevel["task_819_2"].visible = true;
            }
            if(Boolean(conLevel["task819buluTig"]))
            {
               conLevel["task819buluTig"].buttonMode = true;
               conLevel["task819buluTig"].addEventListener(MouseEvent.CLICK,this.onTask819Click);
               conLevel["task819buluTig"].visible = true;
            }
         }
         else
         {
            if(Boolean(animatorLevel["task_819_2"]))
            {
               animatorLevel["task_819_2"].visible = false;
            }
            if(Boolean(conLevel["task819buluTig"]))
            {
               conLevel["task819buluTig"].visible = false;
            }
         }
      }
      
      private function onTask819Click(param1:MouseEvent) : void
      {
         FightInviteManager.fightWithBoss("精灵");
      }
      
      private function initShip() : void
      {
         conLevel["ship"].buttonMode = true;
         conLevel["ship"].addEventListener(MouseEvent.CLICK,this.onShipClick);
      }
      
      private function onShipClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         MainManager.actorModel.moveAndAction(new Point(800,400),function():void
         {
            var ship:MovieClip = null;
            ship = null;
            LevelManager.closeMouseEvent();
            conLevel["ship"].buttonMode = false;
            conLevel["ship"].removeEventListener(MouseEvent.CLICK,onShipClick);
            ship = conLevel["ship"];
            ship.x = 0;
            ship.y = 0;
            MainManager.actorModel.addChildAt(ship,0);
            TweenLite.to(MainManager.actorModel,4,{
               "x":428,
               "y":296,
               "onComplete":function():void
               {
                  LevelManager.openMouseEvent();
                  ship.x = 428;
                  ship.y = 296;
                  conLevel.addChildAt(ship,0);
                  MapManager.changeMap(693);
               }
            });
         });
      }
      
      override public function destroy() : void
      {
      }
   }
}

