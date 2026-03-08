package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_11647 extends BaseMapProcess
   {
      
      private var state:int;
      
      private var bossState:int;
      
      public function MapProcess_11647()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         MainManager.actorInfo.mapID = 11647;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "close":
               this.destroy();
               KTool.changeMapWithCallBack(1,function():void
               {
               });
               break;
            case "btn":
               ModuleManager.showAppModule("TwinBeatStarSweepSubPanel");
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         if(conLevel != null)
         {
            conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         }
         super.destroy();
      }
   }
}

