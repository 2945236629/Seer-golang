package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.taskscollection.Task1083;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.PetModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.utils.CommonUI;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class MapProcess_736 extends BaseMapProcess
   {
      
      private var _luandou:PetModel;
      
      private var _mengyan:PetModel;
      
      public function MapProcess_736()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053218);
         SocketConnection.send(1022,86053219);
         conLevel["mc_spt"].visible = false;
         Task1083.initTaskForMap736(this);
         if(TasksManager.getTaskStatus(1083) != TasksManager.ALR_ACCEPT)
         {
            this.initSpt();
         }
      }
      
      override public function destroy() : void
      {
         CommonUI.removeYellowArrow(MapManager.currentMap.controlLevel);
         if(conLevel["mc_spt"]["npc"])
         {
            conLevel["mc_spt"]["npc"].removeEventListener(MouseEvent.CLICK,this.onStartClick);
         }
         if(conLevel["mc_spt"]["luandou"])
         {
            conLevel["mc_spt"]["luandou"].removeEventListener(MouseEvent.CLICK,this.onLuandouClick);
         }
         if(conLevel["mc_spt"]["mengyan"])
         {
            conLevel["mc_spt"]["mengyan"].removeEventListener(MouseEvent.CLICK,this.onMengyanClick);
         }
         Task1083.destroy();
      }
      
      private function initSpt() : void
      {
         if(BitBuffSetClass.getState(22628))
         {
            this.initFightNpc();
         }
         else
         {
            conLevel["mc_spt"].visible = true;
            conLevel["mc_spt"].gotoAndStop(1);
            conLevel["mc_spt"]["npc"].buttonMode = true;
            conLevel["mc_spt"]["npc"].addEventListener(MouseEvent.CLICK,this.onStartClick);
         }
      }
      
      private function onStartClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         BitBuffSetClass.setState(22628,1);
         conLevel["mc_spt"].gotoAndStop(2);
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("LuandouSptMovie"),function():void
         {
            AnimateManager.playMcAnimate(conLevel["mc_spt"]["mc"],0,"",function():void
            {
               NpcDialog.show(NPC.MENG_YAN,["只要你在这里守候！击败1万人，我就给你挑战我的机会！"],["呵呵。。。"],[function():void
               {
                  NpcDialog.show(NPC.LUAN_DOU,["这不是轻而易举的事情吗！几百年内除了败给探险家的上古精灵以外，我从来没有输过！"],["不要太过自信。。"],[function():void
                  {
                     NpcDialog.show(NPC.MENG_YAN,["无论如何，只要你做到，我就会实现我的诺言！"],["那咱们等着瞧。。"],[function():void
                     {
                        initFightNpc();
                     }]);
                  }]);
               }]);
            });
         });
      }
      
      private function initFightNpc() : void
      {
         conLevel["mc_spt"].visible = true;
         conLevel["mc_spt"].gotoAndStop(3);
         setTimeout(function():void
         {
            CommonUI.addYellowArrow(MapManager.currentMap.controlLevel,740,250);
            conLevel["mc_spt"]["luandou"].buttonMode = true;
            conLevel["mc_spt"]["mengyan"].buttonMode = true;
            conLevel["mc_spt"]["luandou"].addEventListener(MouseEvent.CLICK,onLuandouClick);
            conLevel["mc_spt"]["mengyan"].addEventListener(MouseEvent.CLICK,onMengyanClick);
         },100);
      }
      
      private function onLuandouClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.LUAN_DOU,["你要来挑战我吗？我的胜利数又要多一个了！"],["你好狂妄，让我来教训你！","我好怕，还是算了！"],[function():void
         {
            FightManager.fightWithBoss("乱斗",1);
         }]);
      }
      
      private function onMengyanClick(param1:MouseEvent) : void
      {
         NpcDialog.show(NPC.MENG_YAN,["我就在了这里看着，他到底能不能做到！哈哈哈哈哈！！！"],["你好任性。。"]);
      }
   }
}

