package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.panel.MapNamePanel;
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.TaskIconManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm2;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_10944 extends BaseMapProcess
   {
      
      private static var mapId:int = 0;
      
      private var step:int = 0;
      
      private var _mc:MovieClip;
      
      public function MapProcess_10944()
      {
         super();
      }
      
      private static function onSwitchMap(param1:MapEvent) : void
      {
         MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,onSwitchMap);
         ModuleManager.showAppModule("LeiyisThunderCookBookPanel");
      }
      
      override protected function init() : void
      {
         this._mc = btnLevel["mcUI"];
         if(MapManager.currentMap.id != MapManager.prevMapID)
         {
            mapId = MapManager.prevMapID;
         }
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         TaskIconManager.hideAll();
         MapNamePanel.hide();
         KTool.getMultiValue([16357],function(param1:Array):void
         {
            step = param1[0];
            MovieClip(_mc["mcBar"]).gotoAndStop(step + 1);
            _mc["txtNum"].text = step + "/10";
         });
         this.addEvent();
      }
      
      private function addEvent() : void
      {
         if(this._mc)
         {
            this._mc["btnExit"].addEventListener(MouseEvent.CLICK,this.onExit);
            this._mc["btnBag"].addEventListener(MouseEvent.CLICK,this.onBag);
            this._mc["btnCure"].addEventListener(MouseEvent.CLICK,this.onCure);
         }
         btnLevel["btnBoss"].addEventListener(MouseEvent.CLICK,this.onClickBoss);
      }
      
      private function onClickBoss(param1:MouseEvent) : void
      {
         var _loc2_:Date = SystemTimerManager.sysBJDate;
         if(Boolean(MainManager.actorInfo.isVip) || _loc2_.hours >= 12 && _loc2_.hours < 16 || _loc2_.hours >= 17 && _loc2_.hours < 21)
         {
            this.showDialog();
         }
         else
         {
            Alarm2.show("每天的收集残章时间为12:00-16:00及17:00-21:00,VIP无时间限制！");
         }
      }
      
      private function removeEvent() : void
      {
         if(this._mc)
         {
            this._mc["btnExit"].removeEventListener(MouseEvent.CLICK,this.onExit);
            this._mc["btnBag"].removeEventListener(MouseEvent.CLICK,this.onBag);
            this._mc["btnCure"].removeEventListener(MouseEvent.CLICK,this.onCure);
         }
      }
      
      private function onBag(param1:MouseEvent) : void
      {
         PetBagControllerNew.showByBuffer();
      }
      
      private function onCure(param1:MouseEvent) : void
      {
         PetManager.cureAll();
      }
      
      private function onExit(param1:MouseEvent) : void
      {
         MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,onSwitchMap);
         MapManager.changeMap(mapId);
      }
      
      private function showDialog() : void
      {
         if(this.step < 10)
         {
            NpcDialog.show(NPC.LEIYI_EVO,["勇敢的赛尔，你愿意接受雷神的试炼吗？"],["我愿意！","让我再准备一下。"],[function():void
            {
               NpcDialog.show(NPC.LEIYI_EVO,["此次试炼共10关，全部通过后即可获得珍贵奖励：一份秘典残章！秘典残章可用于增强你的精灵能力。当前你正处于第" + (step + 1) + "关。"],["我要开始挑战！","让我再准备一下。"],[function():void
               {
                  var onFight:Function = null;
                  onFight = function(param1:*):void
                  {
                     FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFight);
                     if((param1.dataObj as FightOverInfo).winnerID == MainManager.actorID)
                     {
                        Alarm2.show("恭喜你通过了本轮试炼，快去进行下一轮试炼吧！");
                     }
                  };
                  var bid:* = 0;
                  var bname:* = "";
                  FightManager.fightNoMapBoss("",5001 + step);
                  FightManager.fightNoMapBoss(bname,bid);
                  FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFight);
               }]);
            }]);
         }
         else
         {
            NpcDialog.show(NPC.LEIYI_EVO,["今天你已经获得过秘典残章了，明天再来继续接受挑战吧！"],["我一定会来！"],[function():void
            {
            }]);
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         TaskIconManager.showAll();
         MapNamePanel.show();
         this.removeEvent();
         this._mc = null;
      }
   }
}

