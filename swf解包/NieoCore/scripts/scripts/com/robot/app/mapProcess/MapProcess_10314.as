package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1621;
   import com.robot.core.CommandID;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_10314 extends BaseMapProcess
   {
      
      private static var teamName:Array = ["烈焰队","绿光队","海啸队"];
      
      private var _scoreList:Array;
      
      private var _myTeam:uint;
      
      public function MapProcess_10314()
      {
         super();
      }
      
      private function getReward(param1:Function = null) : void
      {
         var callback:Function = param1;
         SocketConnection.addCmdListener(47007,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(47007,arguments.callee);
            if(null != callback)
            {
               callback.call();
            }
         });
         SocketConnection.send(47007);
      }
      
      private function checkReward(param1:Function = null) : void
      {
         var callback:Function = param1;
         SocketConnection.addCmdListener(CommandID.LOGIN_CHECK_GET_STATUS,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(CommandID.LOGIN_CHECK_GET_STATUS,arguments.callee);
            var _loc3_:uint = (param1.data as ByteArray).readUnsignedInt();
            if(!_loc3_)
            {
               if(null != callback)
               {
                  callback.call();
               }
            }
         });
         SocketConnection.send(CommandID.LOGIN_CHECK_GET_STATUS,667);
      }
      
      private function setDefault() : void
      {
         SocketConnection.addCmdListener(CommandID.SCREW_WAR_SCORE_INFO,this.onCheckRank);
         SocketConnection.send(CommandID.SCREW_WAR_SCORE_INFO);
         conLevel["phoenix"].visible = false;
      }
      
      private function onClickReward(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("ScrewOverReward"),"正在打开...");
      }
      
      override protected function init() : void
      {
         var func:Function = null;
         SocketConnection.send(1022,86061199);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.setDefault();
         MapListenerManager.add(conLevel["diyage2"],function():void
         {
            var _loc1_:Object = _scoreList[0];
            NpcDialog.show(NPC.SHANGUANG_DIYAGE,["恭喜" + teamName[_loc1_.team - 1] + "和个人总积分超过700的赛尔，快去找贾斯汀站长领奖吧！"],["好，我们这就去！"]);
         });
         MapListenerManager.add(depthLevel["XteamSixth"],function():void
         {
            SocketConnection.send(1022,86059582);
            ModuleManager.showModule(ClientConfig.getAppModule("XTeamSixthMember_Main"),"正在打开...");
         },"X战队圣天使英普瑞斯立即领取");
         MapListenerManager.add(depthLevel["topPet"],function():void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("WatchTowerMainPanel"));
         },"本周热门精灵汇总");
         func = function():void
         {
            getReward(function():void
            {
               NpcDialog.show(NPC.JUSTIN,["拿好你的奖励，继续向未来迈进吧！要记住，不断的努力才能成为赛尔号上的最强者，胜不骄败不馁才是王者应有的风范！"],["我一定会这样做的！"]);
            });
         };
         MapListenerManager.add(conLevel["jiasiting"],function():void
         {
            if(MainManager.actorInfo.crackCupTeamId > 0)
            {
               NpcDialog.show(NPC.JUSTIN,["好样的，年轻人！有我年轻时的风采！ "],["谢谢贾斯汀站长夸奖！"],[function():void
               {
                  checkReward(func);
               }]);
            }
            else
            {
               NpcDialog.show(NPC.JUSTIN,["很遗憾赛尔，你没有参加本届精灵王争霸赛，不能领取象征着胜利与荣耀的奖杯。"],["我一定会来参加下一届的精灵王争霸赛！"]);
            }
         },"贾斯汀");
         MapListenerManager.add(conLevel["luojie"],function():void
         {
            NpcDialog.show(NPC.SHIPER,["干的漂亮，赛尔，快去贾斯汀站长那领取一份你应得的奖励吧！"],["是！我这就去！"]);
         },"罗杰");
      }
      
      private function onCheckRank(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.SCREW_WAR_SCORE_INFO,this.onCheckRank);
         var _loc2_:ByteArray = param1.data as ByteArray;
         var _loc3_:uint = _loc2_.readUnsignedInt();
         var _loc4_:uint = _loc2_.readUnsignedInt();
         var _loc5_:uint = _loc2_.readUnsignedInt();
         this._myTeam = _loc2_.readUnsignedInt();
         var _loc6_:Object = {
            "team":1,
            "score":_loc3_
         };
         var _loc7_:Object = {
            "team":2,
            "score":_loc4_
         };
         var _loc8_:Object = {
            "team":3,
            "score":_loc5_
         };
         this._scoreList = [_loc6_,_loc7_,_loc8_];
         this._scoreList.sort(this.sortFun);
         conLevel["btn1"].gotoAndStop(this._scoreList[0]["team"]);
         conLevel["btn2"].gotoAndStop(this._scoreList[1]["team"]);
         conLevel["btn3"].gotoAndStop(this._scoreList[2]["team"]);
         conLevel["btn1"].buttonMode = true;
         conLevel["btn2"].buttonMode = true;
         conLevel["btn3"].buttonMode = true;
         conLevel["btn1"].addEventListener(MouseEvent.CLICK,this.onClickBtn);
         conLevel["btn2"].addEventListener(MouseEvent.CLICK,this.onClickBtn);
         conLevel["btn3"].addEventListener(MouseEvent.CLICK,this.onClickBtn);
      }
      
      override public function destroy() : void
      {
         Task1621.destroy();
         conLevel["btn1"].removeEventListener(MouseEvent.CLICK,this.onClickBtn);
         conLevel["btn2"].removeEventListener(MouseEvent.CLICK,this.onClickBtn);
         conLevel["btn3"].removeEventListener(MouseEvent.CLICK,this.onClickBtn);
         super.destroy();
      }
      
      private function onClickBtn(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(param1.currentTarget.name.slice(3)) - 1;
         SocketConnection.send(1022,86059634 + _loc2_);
         ModuleManager.showModule(ClientConfig.getAppModule("TeamInfos"),"正在打开...",this._scoreList[_loc2_]["team"]);
      }
      
      private function sortFun(param1:Object, param2:Object) : int
      {
         if(param1["score"] > param2["score"])
         {
            return -1;
         }
         if(param1["score"] < param2["score"])
         {
            return 1;
         }
         return 0;
      }
   }
}

