package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.config.xml.ServerMapsXMLInfo;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   
   public class MapProcess_11876 extends BaseMapProcess
   {
      
      public static var lastlevel:int = -1;
      
      private var nowlevel:int;
      
      private var dailylevel:int;
      
      private const maxlevel:int = 30;
      
      private const levelnames:Array = ["第 1 层 蔷薇之约","第 2 层 稚嫩冰火","第 3 层 勇气前行","第 4 层 无畏前路","第 5 层 狂热之心","第 6 层 王者童心","第 7 层 萌王至上","第 8 层 战斗之始","第 9 层 次元之初","第 10 层 万物丛生","第 11 层燎原之火","第 12 层闪电之躯","第 13 层龙威初现","第 14 层远古觉醒","第 15 层神秘之影","第 16 层机械传说","第 17 层邪影之灵","第 18 层不败君王","第 19 层冰水之间","第 20 层天地之行","第 21 层火电之息","第 22 层远古龙脉","第 23 层暗影之密","第 24 层机械战狂","第 25 层邪灵主宰","第 26 层幻世魅影","第 27 层混沌之灾","第 28 层神圣之光","第 29 层水佑芳草","第 30 层非凡之冰"];
      
      private const npcs:Array = [3339,2842,2962,3034,3080,2996,3109,2963,3232,3354,2738,3149,3035,3371,3081,3393,3240,3340,3105,2988,2739,3036,3200,3223,3561,3529,3734,3711,3740,3886];
      
      private const dialog:Array = ["欢迎你的到来，$！","这里是$，只要你$即可通过本层挑战！","真正的勇士无所畏惧！（开启挑战）","稍后再来"];
      
      private const cons:Array = ["击败对手","击败所有对手","10回合内击败所有对手","10回合内击败所有对手","10回合内击败所有对手","使用3只以内精灵战胜所有对手","使用3只以内精灵战胜所有对手","5回合内战胜对手","5回合内战胜对手","5回合内战胜所有对手","使用致命一击战胜对手","使用物理攻击战胜对手","使用特殊攻击战胜对手","5回合内战胜对手","使用单精灵战胜所有对手","战胜对手时自身血量大于600","战胜对手时自身血量大于800","战斗中最高伤害达到5000并击败对手","使用单精灵10回合以内战胜所有对手","使用单精灵6回合以内战胜所有对手","使用先制技能战胜对手","使用致命一击战胜对手","战胜对手时累计3次以上暴击","战胜时己方能力提升总和高于15","单精灵3回合内战胜对手","战胜对手时血量大于800","战胜对手时血量低于300","单精灵10回合内战胜所有对手","单精灵8回合内战胜所有对手","单精灵战斗中不出现暴击战胜所有对手"];
      
      public function MapProcess_11876()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         topLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         topLevel["panel"].visible = false;
         topLevel["panel"]["mc"].gotoAndStop(1);
         topLevel["panel1"].visible = false;
         topLevel["panel2"].visible = false;
         topLevel["panel2"]["mc"].gotoAndStop(1);
         topLevel["level"].gotoAndStop(1);
         conLevel["npc"].gotoAndStop(1);
         LevelManager.iconLevel.visible = false;
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.fightover);
         this.update();
      }
      
      private function fightover(param1:PetFightEvent) : void
      {
         this.update(true);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         var _loc3_:String = param1.target.parent.name;
         if(_loc3_ == "npc")
         {
            this.showdialog();
            return;
         }
         switch(_loc2_)
         {
            case "close":
               MapManager.changeMap(ServerMapsXMLInfo.getLoginMapId(2));
               break;
            case "go":
               if(this.nowlevel >= this.maxlevel)
               {
                  topLevel["panel"]["mc"].gotoAndStop(1);
                  topLevel["panel"].visible = true;
               }
               else if(this.dailylevel >= 3)
               {
                  topLevel["panel"]["mc"].gotoAndStop(2);
                  topLevel["panel"].visible = true;
               }
               else
               {
                  this.showlevelpanel();
               }
               topLevel["panel1"].visible = false;
               break;
            case "pclose":
               topLevel["panel"].visible = false;
               MapManager.changeMap(ServerMapsXMLInfo.getLoginMapId(2));
         }
      }
      
      private function showlevelpanel() : void
      {
         conLevel.mouseChildren = conLevel.mouseEnabled = false;
         topLevel["panel2"].visible = true;
         topLevel["panel2"]["mc"].gotoAndStop(this.nowlevel + 1);
         StatManager.sendStat2014("0614英雄塔第一弹","进入第" + (this.nowlevel + 1) + "关","2019运营活动");
         setTimeout(function():void
         {
            if(conLevel)
            {
               conLevel.mouseChildren = conLevel.mouseEnabled = true;
            }
            if(Boolean(topLevel) && Boolean(topLevel["panel2"]))
            {
               topLevel["panel2"].visible = false;
            }
         },2000);
      }
      
      private function showdialog() : void
      {
         NpcDialog.show(this.npcs[this.nowlevel],[this.dialog[0].replace(/\$/,MainManager.actorInfo.nick)],null,null,false,function():void
         {
            NpcDialog.show(npcs[nowlevel],[dialog[1].replace(/\$/,levelnames[nowlevel]).replace(/\$/,cons[nowlevel])],[dialog[2],dialog[3]],[function():void
            {
               MapProcess_11876.lastlevel = nowlevel;
               StatManager.sendStat2014("0614英雄塔第一弹","与第" + (nowlevel + 1) + "关精灵王进入战斗","2019运营活动");
               FightManager.fightNoMapBoss("",16438 + nowlevel);
            },null],false,null,true);
         },true);
      }
      
      private function update(param1:Boolean = false) : void
      {
         var boo:Boolean = param1;
         conLevel.mouseChildren = conLevel.mouseEnabled = false;
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
         KTool.getMultiValue([18692,101851],function(param1:Array):void
         {
            var arr:Array = param1;
            nowlevel = arr[1];
            dailylevel = arr[0];
            topLevel["level"].gotoAndStop(nowlevel + 1);
            conLevel["npc"].gotoAndStop(nowlevel + 1);
            if(boo)
            {
               if(nowlevel >= maxlevel)
               {
                  Alarm.show("恭喜你已成功通关所有挑战，并获得全新成就称号——精灵王之约！",function():void
                  {
                     MapManager.changeMapWithCallback(ServerMapsXMLInfo.getLoginMapId(2),function():void
                     {
                        ModuleManager.showAppModule("HeroTowerMainPanel");
                     });
                  });
                  return;
               }
               if(nowlevel > MapProcess_11876.lastlevel)
               {
                  topLevel["panel1"].visible = true;
                  topLevel["panel1"]["num"].text = nowlevel;
               }
               else if(FightManager.isWin)
               {
                  Alarm.show("要按要求战胜对手，才能完成挑战哦！");
               }
            }
            else
            {
               showlevelpanel();
            }
            conLevel.mouseChildren = conLevel.mouseEnabled = true;
            topLevel.mouseChildren = topLevel.mouseEnabled = true;
         });
      }
      
      override public function destroy() : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.fightover);
         LevelManager.iconLevel.visible = true;
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         topLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
      }
   }
}

