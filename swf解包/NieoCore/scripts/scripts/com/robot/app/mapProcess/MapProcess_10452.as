package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.MapEvent;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10452 extends BaseMapProcess
   {
      
      public function MapProcess_10452()
      {
         super();
      }
      
      private static function onSwitchMap(param1:MapEvent) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,onSwitchMap);
         if(MapManager.currentMap.id == 101)
         {
            ModuleManager.showModule(ClientConfig.getAppModule("YougesarongMainPanel"));
         }
         else
         {
            MapManager.changeMap(101);
         }
      }
      
      override protected function init() : void
      {
         if(!BufferRecordManager.getMyState(1066))
         {
            getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(false);
            this.playPreStory();
         }
         else
         {
            MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,onSwitchMap);
         }
      }
      
      private function playPreStory() : void
      {
         NpcDialog.show(NPC.LYMAN,["宇宙中的邪恶势力正在日益加剧，宇宙的另一端0xff0000暗黑魔君索伦森0xffffff也在蠢蠢欲动，相信他们的目标不仅仅是赛尔号，他们要的是整个宇宙！"],["雷蒙教官，我们该怎么办呢？"],[function():void
         {
            NpcDialog.show(NPC.LYMAN,["放心吧！只要有我雷蒙在，谁都别想伤害赛尔号，我们是为了守卫宇宙能源以及和平而存在，赛尔号的战士一定会战斗到底！"],["算我一个，我也会战斗到底！"],[function():void
            {
               AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("map_10452_0"),function():void
               {
                  NpcDialog.show(NPC.LYMAN,["眼看着我训练出来的优秀士兵在前线作战，我一定要做些什么，可恶的海盗，我一定不会放过你的！"],["雷蒙教官，你要亲自出马吗？！"],[function():void
                  {
                     NpcDialog.show(NPC.LYMAN,["不单单是我一个人，还有我的秘密武器，雷蒙教官一旦生气，后果很严重！"],["秘密武器？快让我看看，究竟是什么呀！"],[function():void
                     {
                        AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("active_20140221_6"),function():void
                        {
                           NpcDialog.show(NPC.SEER,["雷蒙教官，他们是谁？怎么会出现在飞船上！"],["传说果然是真的！"],[function():void
                           {
                              NpcDialog.show(NPC.SEER,["就让我带着0xff0000铁血意志—尤格萨隆0xffffff，去击碎这些可恶的海盗吧！"],["加油啊！雷蒙教官！"],[function():void
                              {
                                 AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("map_10452_1"),function():void
                                 {
                                    BufferRecordManager.setMyState(1066,true);
                                    SocketConnection.send(1022,86069623);
                                    getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(true);
                                    MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,onSwitchMap);
                                    MapManager.changeMap(101);
                                 });
                              }]);
                           }]);
                        });
                     }]);
                  }]);
               });
            }]);
         }]);
      }
      
      override public function destroy() : void
      {
      }
   }
}

