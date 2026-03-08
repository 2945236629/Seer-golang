package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   
   public class MapProcess_11305 extends BaseMapProcess
   {
      
      public static var IsFirstWin:Boolean = false;
      
      public function MapProcess_11305()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.getForeverNum(102072,function(param1:int):void
         {
            if(KTool.getBit(param1,1) == 0)
            {
               MapListenerManager.add(conLevel["mv"]["lexiaoban"],onLeXiaoBanClick);
            }
         });
      }
      
      private function onLeXiaoBanClick(param1:* = null) : void
      {
         var e:* = param1;
         NpcDialog.show(NPC.LEXIAOBAN,["我们来自于遥远的星系，喜欢星际旅行，经过这里的时候我的同伴被海盗抓走了！小赛尔，你可以帮助我救回小伙伴嘛？"],["必须的！可是我们要如何营救他们呢？"],[function():void
         {
            NpcDialog.show(NPC.LEXIAOBAN,["这荒山野岭的，你能找到他们的具体位置吗？"],["不必担心！"],[function():void
            {
               NpcDialog.show(NPC.LEXIAOBAN,["太感谢你了！我们都会带一只特殊的KIDO智能手表，通过先进的系统，可以做到有问必答哦！虽然被抓，但是我们依然可以保持通信，还能定位呢！"],["啊！这么强大！那我们快去找他们吧！"],[function():void
               {
                  NpcDialog.show(NPC.LEXIAOBAN,["海盗实力太强了，人数也众多,我们必须练习一下战术！"],["好！那就开始吧！","稍等！我准备一下！","额…..暂时想离开这里!"],[function():void
                  {
                     FightManager.fightNoMapBossByCmd(45678,[1],onFightOver);
                  },null,goMainPanel]);
               }]);
            }]);
         }]);
      }
      
      private function goMainPanel() : void
      {
         ModuleManager.showAppModule("WatchTaskPanel");
      }
      
      private function onFightOver() : void
      {
         KTool.getForeverNum(102072,function(param1:int):void
         {
            var value:int = param1;
            if(KTool.getBit(value,1) != 0)
            {
               IsFirstWin = true;
               MapManager.currentMap.controlLevel["mv"].gotoAndStop(2);
               AnimateManager.playMcAnimate(MapManager.currentMap.controlLevel["mv"],2,"mv",function():void
               {
                  MapManager.changeLocalMap(11306);
               });
            }
         });
      }
   }
}

