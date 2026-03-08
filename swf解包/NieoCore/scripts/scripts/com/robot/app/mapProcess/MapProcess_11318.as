package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.panel.MapNamePanel;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
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
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_11318 extends BaseMapProcess
   {
      
      private var progress:int;
      
      private var ans:Array = ["就是有救兵我也不怕！看你文文弱弱的样子，恐怕谁也打不过吧！","我……我卷子不是已经还给你了吗？为什么还要打我？","好好好，没完了是吧！我不反抗了，来吧！"];
      
      private var que:Array = ["哼，快把卷子还给我！","不好意思，抢人财务是要付出代价的！","以后不许再干坏事了！"];
      
      public function MapProcess_11318()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.getMultiValue([14248],function(param1:Array):void
         {
            progress = param1[0];
         });
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         MapNamePanel.hide();
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
      }
      
      private function onClick(param1:MouseEvent) : void
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
      
      private function npcClick() : void
      {
         NpcDialog.show(NPC.HAI_DAO,[this.ans[this.progress]],[this.que[this.progress],"看我用钻石砸晕你！","我要再准备一下。"],[this.fight,this.diamond,null]);
      }
      
      private function fight() : void
      {
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(param1.dataObj.winnerID == MainManager.actorInfo.userID)
            {
               yiQi();
            }
         });
         FightManager.tryFight(442,[0,0,0,0]);
      }
      
      private function yiQi() : void
      {
         KTool.getMultiValue([14247],function(param1:Array):void
         {
            var a:Array = param1;
            progress = a[0];
            if(a[0] >= 3)
            {
               NpcDialog.show(NPC.BO_QIE_ER,["谢谢你，小赛尔！这下我的主人再也不用发愁啦！"],["不客气！"],[function():void
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
            else
            {
               npcClick();
            }
         });
      }
      
      private function diamond() : void
      {
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         KTool.getMultiValue([14247],function(param1:Array):void
         {
            var a:Array = param1;
            progress = a[0];
            KTool.buyProductByCallback(248511,1,function():void
            {
               SocketConnection.sendWithCallback(46240,function(param1:SocketEvent):void
               {
                  yiQi();
               },6,7 + a[0]);
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
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

