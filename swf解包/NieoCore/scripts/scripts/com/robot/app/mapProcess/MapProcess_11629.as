package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_11629 extends BaseMapProcess
   {
      
      private var state:int;
      
      public function MapProcess_11629()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         LevelManager.toolsLevel.visible = false;
         KTool.getMultiValue([101458],function(param1:Array):void
         {
            state = param1[0];
            conLevel.addEventListener(MouseEvent.CLICK,onConClick);
            playStory();
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "fight":
               FightManager.fightNoMapBoss("纳纳",12336);
               break;
            case "close":
               this.destroy();
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("PlantsAssistanceMainPanel");
               });
               break;
            case "bag":
               ModuleManager.showAppModule("ADPetBagPanelNew");
               break;
            case "cure":
               PetManager.cureAllFree();
         }
      }
      
      private function playStory() : void
      {
         /*
          * 反编译出错
          * 到达超时限制 (1 分) 
          * 指令数: 67
          */
         throw new flash.errors.IllegalOperationError("由于超时未反编译");
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         LevelManager.toolsLevel.visible = true;
         if(conLevel != null)
         {
            conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         }
         super.destroy();
      }
   }
}

