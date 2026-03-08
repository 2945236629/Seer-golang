package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.panel.MapNamePanel;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11349 extends BaseMapProcess
   {
      
      public function MapProcess_11349()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         this.show();
      }
      
      private function show() : void
      {
         animatorLevel.visible = false;
         MapNamePanel.hide();
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         LevelManager.iconLevel.visible = false;
         KTool.getMultiValue([5387],function(param1:Array):void
         {
            conLevel["numTxt"].text = KTool.getByte(param1[0],1) + "/3";
            if(KTool.getByte(param1[0],1) >= 3)
            {
               yiQi();
            }
         });
      }
      
      public function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "boss":
               this.npcClick();
               break;
            case "close":
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showAppModule("ChuanChengQuestionPanel");
               });
         }
      }
      
      public function npcClick() : void
      {
         this.fight();
      }
      
      public function fight() : void
      {
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
         });
         FightManager.tryFight(462,[0,0,0,0]);
      }
      
      public function yiQi() : void
      {
         animatorLevel.visible = true;
         conLevel.visible = false;
         AnimateManager.playMcAnimate(animatorLevel as MovieClip,1,"mc",function():void
         {
            animatorLevel.visible = false;
            conLevel.visible = true;
            MapManager.currentMap.depthLevel.visible = true;
            MapManager.changeMapWithCallback(1,function():void
            {
               ModuleManager.showAppModule("ChuanChengQuestionPanel");
            });
         });
      }
      
      override public function destroy() : void
      {
         KTool.showMapAllPlayerAndMonster(true);
         ToolBarController.showOrHideAllUser(true);
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         MapNamePanel.show();
         MainManager.selfVisible = true;
         conLevel["boss"].removeEventListener(MouseEvent.CLICK,this.npcClick);
         super.destroy();
      }
   }
}

