package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11704 extends BaseMapProcess
   {
      
      private var pro:int;
      
      private var _lefttime:int;
      
      private var colidx:int = -1;
      
      private var hidenum:int;
      
      public function MapProcess_11704()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("0817主题活动","进入月光场景","2018运营活动");
         KTool.petFollow(3710);
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         SystemTimerManager.addTickFun(this.timeHandle);
         this.update(true);
      }
      
      private function timeHandle() : void
      {
         if(this.lefttime > 0)
         {
            --this.lefttime;
            if(this.lefttime <= 0)
            {
               ++this.hidenum;
               conLevel["mc_" + this.colidx].visible = false;
               this.lefttime = 0;
               Alarm.show("此处收集完成！");
               if(this.hidenum >= 3)
               {
                  SocketConnection.sendByQueue(43300,[18,3],function(param1:*):void
                  {
                     var e:* = param1;
                     update();
                     NpcDialog.show(2890,["赞美月神，能让我见到如此奇异的果实！这一定是月神的恩赐，看来今天可以一饱口舌了！"],["糟了，有人想抢夺果实！"],[function():void
                     {
                        ModuleManager.showAppModule("MoyayaGiftTipPanel",1);
                     }],false,null,true);
                  });
               }
            }
         }
      }
      
      private function onWalkEnter(param1:RobotEvent) : void
      {
         var _loc2_:Point = new Point();
         _loc2_ = MainManager.actorModel.parent.globalToLocal(conLevel["mc_0"].localToGlobal(new Point(0,0)));
         var _loc3_:Point = new Point();
         _loc3_ = MainManager.actorModel.parent.globalToLocal(conLevel["mc_1"].localToGlobal(new Point(0,0)));
         var _loc4_:Point = new Point();
         _loc4_ = MainManager.actorModel.parent.globalToLocal(conLevel["mc_2"].localToGlobal(new Point(0,0)));
         if(conLevel["mc_0"] && Point.distance(_loc2_,MainManager.actorModel.pos) < 60 && Boolean(conLevel["mc_0"].visible))
         {
            if(this.colidx != 0)
            {
               StatManager.sendStat2014("0817主题活动","触发月光场景收集进度条","2018运营活动");
               this.colidx = 0;
               this.lefttime = 5;
            }
         }
         else if(conLevel["mc_0"].visible)
         {
            if(this.colidx == 0 && this.lefttime > 0)
            {
               this.colidx = -1;
               this.lefttime = 0;
            }
         }
         if(conLevel["mc_1"] && Point.distance(_loc3_,MainManager.actorModel.pos) < 60 && Boolean(conLevel["mc_1"].visible))
         {
            if(this.colidx != 1)
            {
               StatManager.sendStat2014("0817主题活动","触发月光场景收集进度条","2018运营活动");
               this.colidx = 1;
               this.lefttime = 5;
            }
         }
         else if(conLevel["mc_1"].visible)
         {
            if(this.colidx == 1 && this.lefttime > 0)
            {
               this.colidx = -1;
               this.lefttime = 0;
            }
         }
         if(conLevel["mc_2"] && Point.distance(_loc4_,MainManager.actorModel.pos) < 60 && Boolean(conLevel["mc_2"].visible))
         {
            if(this.colidx != 2)
            {
               StatManager.sendStat2014("0817主题活动","触发月光场景收集进度条","2018运营活动");
               this.colidx = 2;
               this.lefttime = 5;
            }
         }
         else if(conLevel["mc_2"].visible)
         {
            if(this.colidx == 2 && this.lefttime > 0)
            {
               this.colidx = -1;
               this.lefttime = 0;
            }
         }
      }
      
      private function update(param1:Boolean = false) : void
      {
         var boo:Boolean = param1;
         LevelManager.closeMouseEvent();
         KTool.getMultiValue([16929],function(param1:Array):void
         {
            var i:int = 0;
            var arr:Array = param1;
            pro = arr[0];
            conLevel["mc"].visible = pro < 6;
            conLevel["boss"].visible = pro == 5;
            conLevel["mc"].gotoAndStop(pro - 3);
            LevelManager.openMouseEvent();
            i = 0;
            while(i < 3)
            {
               conLevel["mc_" + i].visible = pro == 4;
               conLevel["mc_" + i].mouseChildren = conLevel["mc_" + i].mouseEnabled = false;
               i++;
            }
            if(boo && pro == 4)
            {
               i = 0;
               while(i < 3)
               {
                  conLevel["mc_" + i].visible = false;
                  i++;
               }
               NpcDialog.show(NPC.SEER,["果实就快要成熟了！如此费时费力，这枚果子一定不简单！"],["太好了，菇菇发马上就能吃到最好吃的果子了！"],[function():void
               {
                  NpcDialog.show(3710,["还差一些月光之力，今天就能结出一枚果子了！我会将月光之力最浓郁的地方标注出来，你需要带着我去那里汲取力量。"],["好的！"],[function():void
                  {
                     i = 0;
                     while(i < 3)
                     {
                        conLevel["mc_" + i].visible = true;
                        ++i;
                     }
                  }],false,null,true);
               }]);
            }
            if(pro == 6)
            {
               ModuleManager.showAppModule("MoyayaGiftTipPanel",1);
            }
         });
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var idx:int = 0;
         var e:MouseEvent = param1;
         var ename:String = e.target.name;
         switch(ename)
         {
            case "boss":
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               });
               FightManager.fightNoMapBoss("",13800);
         }
      }
      
      override public function destroy() : void
      {
         KTool.petDestroy();
         MainManager.actorModel.destroymoyayataskIcon();
         SystemTimerManager.removeTickFun(this.timeHandle);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
      
      public function get lefttime() : int
      {
         return this._lefttime;
      }
      
      public function set lefttime(param1:int) : void
      {
         this._lefttime = param1;
         if(this.lefttime > 0)
         {
            MainManager.actorModel.addmoyayataskIcon();
            MainManager.actorModel.updatemoyayataskIcon(this.lefttime,5);
         }
         else
         {
            MainManager.actorModel.destroymoyayataskIcon();
         }
      }
   }
}

