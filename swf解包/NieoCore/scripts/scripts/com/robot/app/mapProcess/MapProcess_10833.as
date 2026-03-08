package com.robot.app.mapProcess
{
   import com.robot.app.control.DYMHController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_10833 extends BaseMapProcess
   {
      
      public function MapProcess_10833()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(DYMHController.FightFlag)
         {
            DYMHController.FightFlag = false;
            this.hideAllMov();
            conLevel["mc_npc_2"]["mc_xiaoxi"].mouseChildren = false;
            conLevel["mc_npc_2"].visible = true;
            conLevel["mc_npc_2"].buttonMode = true;
            conLevel["mc_npc"].visible = false;
            conLevel["mc_npc"].buttonMode = false;
            NpcDialog.show(NPC.ALLISON,["你永远不会知道Neo的疑惑是什么，哈哈哈！那就送给你作为礼物！自己慢慢去想吧！"],["……好。"],[function():void
            {
               SocketConnection.sendWithCallback(43580,function():void
               {
                  hideAll();
                  ModuleManager.showAppModule("DYMHPanel");
               },5);
            }]);
         }
         else
         {
            this.hideAllMov();
            conLevel["mc_npc_2"].visible = false;
            conLevel["mc_npc_2"].buttonMode = true;
            conLevel["mc_npc"].visible = true;
            conLevel["mc_npc"].buttonMode = true;
            conLevel["mc_npc"].addEventListener(MouseEvent.CLICK,this.onNpcClick);
            conLevel["mc_npc_2"].addEventListener(MouseEvent.CLICK,this.onNpc2Click);
         }
      }
      
      override public function destroy() : void
      {
         conLevel["mc_npc"].removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         conLevel["mc_npc_2"].removeEventListener(MouseEvent.CLICK,this.onNpc2Click);
         super.destroy();
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.SEER,["是否要叫醒昏睡中的赛小息？"],["不，就让他这样睡着。","还是叫醒他吧。"],[function():void
         {
            SocketConnection.send(41129,3285);
         },function():void
         {
            conLevel["mc_npc"].visible = false;
            conLevel["mc1"].visible = true;
            playMov();
            AnimateManager.playMcAnimate(conLevel["mc1"],0,"",function():void
            {
               NpcDialog.show(NPC.SEER,["天！这到底是哪里？"],["咦…那不是艾利逊吗？"],[function():void
               {
                  NpcDialog.show(NPC.SAIXIAOXI,["他怎么又出现了….难道海盗的势力并没有完全的被消灭干净？"],["赛小息！醒醒！"],[function():void
                  {
                     NpcDialog.show(NPC.ALLISON,["各位正义的朋友们！从现在开始，我们要对宇宙中最邪恶的赛尔号飞船！发起攻击！从过去到现在，我们的光芒从未驱散过黑夜！但是这一次！我们绝不！"],[" "],[function():void
                     {
                        conLevel["mc_npc"].visible = false;
                        conLevel["mc1"].visible = false;
                        conLevel["mc2"].visible = true;
                        playMov();
                        AnimateManager.playMcAnimate(conLevel["mc2"],0,"",function():void
                        {
                           hideAllMov();
                           LevelManager.iconLevel.visible = true;
                           MainManager.actorModel.visible = true;
                           conLevel["mc_npc_2"].visible = true;
                        });
                     }]);
                  }]);
               }]);
            });
         }]);
      }
      
      private function onNpc2Click(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case conLevel["mc_npc_2"]["mc_xiaoxi"]:
               this.onSXXClick();
               break;
            case conLevel["mc_npc_2"]["mc_alixun"]:
               this.onADXClick();
         }
      }
      
      private function onSXXClick() : void
      {
         NpcDialog.show(NPC.SAIXIAOXI,["请认真的做出选择，你的选择，将会影响最后的奖励。"],["我不相信你，赛小息。","我相信你。"],[function():void
         {
            conLevel["mc_npc_2"].visible = false;
            hideAllMov();
            conLevel["mc3"].visible = true;
            playMov();
            AnimateManager.playMcAnimate(conLevel["mc3"],0,"",function():void
            {
               LevelManager.iconLevel.visible = true;
               MainManager.actorModel.visible = true;
               hideAllMov();
               SocketConnection.sendWithCallback(43580,function():void
               {
                  hideAll();
                  ModuleManager.showAppModule("DYMHPanel");
               },1);
            });
         },function():void
         {
            NpcDialog.show(NPC.ALLISON,["你的选择居然会是这样，那么，我们现在就是敌人！"],["敌人就敌人！我不怕！（进入战斗）"],[function():void
            {
               DYMHController.FightFlag = true;
               SocketConnection.send(41129,3286);
            }]);
         }]);
      }
      
      private function onADXClick() : void
      {
         NpcDialog.show(NPC.ALLISON,["请认真的做出选择，你的选择，将会影响最后的奖励。"],["我不相信你，艾利逊。","我相信你。"],[function():void
         {
            NpcDialog.show(NPC.ALLISON,["你的选择居然会是这样，那么，我们现在就是敌人！"],["敌人就敌人！我不怕！（进入战斗）"],[function():void
            {
               DYMHController.FightFlag = true;
               SocketConnection.send(41129,3286);
            }]);
         },function():void
         {
            hideAllMov();
            conLevel["mc3"].visible = true;
            playMov();
            AnimateManager.playMcAnimate(conLevel["mc3"],0,"",function():void
            {
               LevelManager.iconLevel.visible = true;
               MainManager.actorModel.visible = true;
               hideAllMov();
               SocketConnection.sendWithCallback(43580,function():void
               {
                  hideAll();
                  ModuleManager.showAppModule("DYMHPanel");
               },1);
            });
         }]);
      }
      
      private function playMov() : void
      {
         LevelManager.iconLevel.visible = false;
         MainManager.actorModel.visible = false;
      }
      
      private function hideAllMov() : void
      {
         conLevel["mc1"].visible = false;
         conLevel["mc2"].visible = false;
         conLevel["mc3"].visible = false;
      }
      
      private function hideAll() : void
      {
         LevelManager.iconLevel.visible = true;
         this.hideAllMov();
         conLevel["mc_npc"].visible = false;
         conLevel["mc_npc_2"].visible = false;
         MainManager.actorModel.visible = true;
      }
   }
}

