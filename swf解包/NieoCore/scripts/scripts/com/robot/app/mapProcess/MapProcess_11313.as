package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.panel.MapNamePanel;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm2;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_11313 extends BaseMapProcess
   {
      
      public function MapProcess_11313()
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
         if(BitBuffSetClass.getState(23248) == 0)
         {
            animatorLevel.visible = true;
            conLevel.visible = false;
            MapManager.currentMap.depthLevel.visible = false;
            LevelManager.iconLevel.visible = false;
            AnimateManager.playMcAnimate(animatorLevel as MovieClip,1,"mc",function():void
            {
               BitBuffSetClass.setState(23248,1);
               animatorLevel.visible = false;
               conLevel.visible = true;
               MapManager.currentMap.depthLevel.visible = true;
            });
         }
      }
      
      public function onClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "boss":
               this.npcClick();
               break;
            case "bagBtn":
               ModuleManager.showAppModule("ADPetBagPanelNew");
               break;
            case "cureBtn":
               PetManager.cureAllFree();
               break;
            case "close":
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showAppModule("SummerWorkPanel");
               });
         }
      }
      
      public function npcClick() : void
      {
         NpcDialog.show(NPC.HAI_DAO,["就是有救兵我也不怕！看你文文弱弱的样子，恐怕谁也打不过吧！"],["哼，快把卷子还给我！","看我用钻石砸晕你！","我要再准备一下。"],[this.fight,this.diamond,null]);
      }
      
      public function fight() : void
      {
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(param1.dataObj.winnerID == MainManager.actorInfo.userID)
            {
               yiQi();
            }
         });
         FightManager.tryFight(436,[0,0,0,0]);
      }
      
      public function yiQi() : void
      {
         NpcDialog.show(NPC.XIAO_YOU,["谢谢你，小赛尔！这下我的主人再也不用发愁啦！"],["不客气！"],[function():void
         {
            ToolBarController.panel.hide();
            LevelManager.iconLevel.visible = false;
            Alarm2.show("你完成了这次营救任务，快去看看有没有别人需要你的帮助吧！",function():void
            {
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showAppModule("SummerWorkPanel");
               });
            });
         }]);
      }
      
      public function diamond() : void
      {
         ToolBarController.panel.hide();
         KTool.buyProductByCallback(248511,1,function():void
         {
            SocketConnection.sendWithCallback(46240,function(param1:SocketEvent):void
            {
               yiQi();
            },6,1);
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

