package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_993 extends BaseMapProcess
   {
      
      public function MapProcess_993()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("天蛇之泪！终极战！","进入活动场景",StatManager.RUN_ACT);
         getDefinitionByName("com.robot.app2.control.SnakeTearController").checkTask(this);
         this.initSptWalien();
      }
      
      private function initSptWalien() : void
      {
         ResourceManager.getResource(ClientConfig.getMapAnimate("spt_walien"),function(param1:MovieClip):void
         {
            var mv:MovieClip = param1;
            conLevel.addChild(mv);
            MapListenerManager.add(mv,function(param1:MouseEvent):void
            {
               var e:MouseEvent = param1;
               if(!BufferRecordManager.getMyState(1160))
               {
                  BufferRecordManager.setMyState(1160,true);
                  AnimateManager.playMcAnimate(mv,2,"mv",function():void
                  {
                     mv.gotoAndStop(1);
                     NpcDialog.show(NPC.WALIEN,["哼哼哼，佣金这么少，还要跑这么远的路，真心亏大了！"],["你在这干什么，你这可恶的雇佣兵！"],[function():void
                     {
                        NpcDialog.show(NPC.WALIEN,["小赛尔，不要来多管闲事，要不是为了想让伊洛维奇见识下我的能力，我根本不屑于和你交手！"],["可恶，看招！","容我三思"],[function():void
                        {
                           FightManager.fightWithBoss("瓦里恩",0);
                        }]);
                     }]);
                  });
               }
               else
               {
                  NpcDialog.show(NPC.WALIEN,["哼哼哼，佣金这么少，还要跑这么远的路，真心亏大了！"],["你在这干什么，你这可恶的雇佣兵！"],[function():void
                  {
                     NpcDialog.show(NPC.WALIEN,["小赛尔，不要来多管闲事，要不是为了想让伊洛维奇见识下我的能力，我根本不屑于和你交手！"],["可恶，看招！","容我三思"],[function():void
                     {
                        FightManager.fightWithBoss("瓦里恩",0);
                     }]);
                  }]);
               }
            },"瓦里恩");
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

