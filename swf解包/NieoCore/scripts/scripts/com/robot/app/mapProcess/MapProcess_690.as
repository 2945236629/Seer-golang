package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.animate.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import org.taomee.manager.*;
   
   public class MapProcess_690 extends BaseMapProcess
   {
      
      private var spring:MovieClip;
      
      private var count:int = 0;
      
      public function MapProcess_690()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["task810mc"].visible = false;
         conLevel["guide"].visible = false;
         conLevel["guide694"].visible = false;
         conLevel["task821mc"].visible = false;
         this.initForNextScene();
         Task810.initForMap690(this);
         Task815.initForMap690(this);
         Task821.initForMap690(this);
         Task832.initForMap690(this);
         Task836.initForMap690(this);
      }
      
      public function initForNextScene() : void
      {
         this.spring = conLevel["spring"];
         this.spring.buttonMode = true;
         this.spring.addEventListener(MouseEvent.CLICK,this.enterScene);
      }
      
      private function enterScene(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this.count == 0)
         {
            ++this.count;
            return;
         }
         if(this.spring.currentFrame == 1)
         {
            conLevel["guide"].visible = false;
            this.spring.mouseEnabled = false;
            AnimateManager.playMcAnimate(this.spring,2,"mc",function():void
            {
               spring.mouseEnabled = true;
               ToolTipManager.add(spring,"暗物质神殿");
            });
         }
         else
         {
            MainManager.actorModel.moveAndAction(new Point(400,320),function():void
            {
               MapManager.changeMap(692);
            });
         }
      }
      
      override public function destroy() : void
      {
         Task810.destroy();
         Task815.destroy();
         Task821.destroy();
         Task832.destroy();
         Task836.destroy();
         conLevel["spring"].removeEventListener(MouseEvent.CLICK,this.enterScene);
         this.spring.removeEventListener(MouseEvent.CLICK,this.enterScene);
         this.spring = null;
         super.destroy();
      }
   }
}

