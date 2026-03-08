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
   import com.robot.core.ui.alert.Alarm2;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11351 extends BaseMapProcess
   {
      
      private var count:int;
      
      public function MapProcess_11351()
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
         MapManager.currentMap.animatorLevel.visible = false;
         MapNamePanel.hide();
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         LevelManager.iconLevel.visible = false;
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
            var e:PetFightEvent = param1;
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(e.dataObj.winnerID == MainManager.actorInfo.userID)
            {
               Alarm2.show("恭喜你抢夺到1个电能石",function():void
               {
                  KTool.getMultiValue([5387],function(param1:Array):void
                  {
                     MapManager.currentMap.controlLevel["numTxt"].text = KTool.getByte(param1[0],2) + "/6";
                     if(KTool.getByte(param1[0],2) >= 6)
                     {
                        yiQi();
                     }
                  });
               });
            }
         });
         FightManager.fightNoMapBoss("",7958);
      }
      
      public function yiQi() : void
      {
         MapManager.currentMap.animatorLevel.visible = true;
         MapManager.currentMap.controlLevel.visible = false;
         AnimateManager.playMcAnimate(MapManager.currentMap.animatorLevel as MovieClip,1,"mc",function():void
         {
            MapManager.currentMap.animatorLevel.visible = false;
            MapManager.currentMap.controlLevel.visible = true;
            MapManager.currentMap.depthLevel.visible = true;
            MapManager.changeMapWithCallback(1,function():void
            {
               ModuleManager.showAppModule("ChuanChengZhiJianPanel");
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

