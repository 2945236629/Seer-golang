package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_10798 extends BaseMapProcess
   {
      
      public function MapProcess_10798()
      {
         super();
      }
      
      override public function setup() : void
      {
         super.setup();
         if(!BitBuffSetClass.getState(22625))
         {
            ResourceManager.getResource(ClientConfig.getMapAnimate("MengPetAlliance_movie"),function(param1:MovieClip):void
            {
               var taskMC:MovieClip = param1;
               BitBuffSetClass.setState(22625,1);
               LevelManager.iconLevel.visible = false;
               KTool.showMapAllPlayerAndMonster(false);
               conLevel.addChild(taskMC);
               depthLevel.visible = false;
               AnimateManager.playMcAnimate(taskMC,1,"mc",function():void
               {
                  LevelManager.iconLevel.visible = true;
                  KTool.showMapAllPlayerAndMonster(true);
                  conLevel.removeChild(taskMC);
                  depthLevel.visible = true;
                  initState();
               });
            });
         }
         else
         {
            this.initState();
         }
      }
      
      private function initState() : void
      {
         CommonUI.addYellowExcal(btnLevel,410,204);
         btnLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(param1.target.name == "btn_npc")
         {
            ModuleManager.showModule(ClientConfig.getAppModule("MengPetAllianceZhuquePanel"));
         }
      }
      
      override public function destroy() : void
      {
         CommonUI.removeYellowExcal(btnLevel);
         btnLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

