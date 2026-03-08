package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_10839 extends BaseMapProcess
   {
      
      public function MapProcess_10839()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.hideAllMov();
         conLevel["mc_npc"].visible = true;
         conLevel["mc_npc"].buttonMode = true;
         conLevel["mc_npc"].addEventListener(MouseEvent.CLICK,this.onNpcClick);
      }
      
      override public function destroy() : void
      {
         conLevel["mc_npc"].removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         super.destroy();
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.SEER,["赛小息！给我起来！这都什么时候了！还在睡觉！"],["我不要，我不要，我头好痛！"],[function():void
         {
            NpcDialog.show(NPC.SEER,["真没有办法，要么我把他先拖走吧。"],[" "],[function():void
            {
               conLevel["mc_npc"].visible = false;
               conLevel["mc1"].visible = true;
               playMov();
               AnimateManager.playMcAnimate(conLevel["mc1"],0,"",function():void
               {
                  NpcDialog.show(NPC.ZOG,["就是因为你！！就是因为你，我们海盗一直在过着最底层的生活！"],["喂喂，你们本来就是邪恶的啊。"],[function():void
                  {
                     NpcDialog.show(NPC.SEER,["你到底想要说什么？"],["我……"],[function():void
                     {
                        NpcDialog.show(NPC.ZOG,["这样暗无天日的生活我一天都过不下去了！我无法忍受！我要报仇！你为什么还会这么好好的活着！"],["你说什么，佐格？"],[function():void
                        {
                           conLevel["mc_npc"].visible = false;
                           conLevel["mc1"].visible = false;
                           conLevel["mc2"].visible = true;
                           playMov();
                           AnimateManager.playMcAnimate(conLevel["mc2"],0,"",function():void
                           {
                              NpcDialog.show(NPC.ZOG,["Neo，终于在赛尔历46年，有人解决了你的第二个疑惑。"],["Neo之疑惑？"],[function():void
                              {
                                 hideAll();
                                 SocketConnection.sendWithCallback(43580,function():void
                                 {
                                    ModuleManager.showAppModule("DYMHPanel");
                                 },2);
                              }]);
                           });
                        }]);
                     }]);
                  }]);
               });
            }]);
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
      }
      
      private function hideAll() : void
      {
         LevelManager.iconLevel.visible = true;
         this.hideAllMov();
         conLevel["mc_npc"].visible = false;
         MainManager.actorModel.visible = true;
      }
   }
}

