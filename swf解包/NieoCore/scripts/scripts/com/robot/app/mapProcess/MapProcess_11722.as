package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.utils.CommonUI;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_11722 extends BaseMapProcess
   {
      
      private var curnpc:*;
      
      private var lefttime:int;
      
      private var npcmc:MovieClip;
      
      private var step:int;
      
      private var tasktype:int;
      
      public function MapProcess_11722()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["movie"].visible = false;
         conLevel["movie"].gotoAndStop(1);
         MainManager.actorModel.hideNono();
         MainManager.actorModel.visible = false;
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         ResourceManager.getResource(ClientConfig.getPetSwfPath(400),this.onLoad,"pet");
         LevelManager.iconLevel.visible = false;
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         SystemTimerManager.addTickFun(this.timerHandle);
         conLevel["mc2"].visible = false;
         this.refreshstate();
      }
      
      private function refreshstate(param1:Function = null) : void
      {
         var fun:Function = param1;
         LevelManager.closeMouseEvent();
         KTool.getMultiValue([14573,14574],function(param1:Array):void
         {
            var arr:Array = param1;
            ItemManager.updateItems([1717990],function():void
            {
               var num:int;
               step = arr[0];
               tasktype = arr[1];
               if(step == 0)
               {
                  conLevel["mc1"].visible = true;
                  conLevel["mc"].visible = false;
                  CommonUI.setEnabled(conLevel["npc2"],true);
                  CommonUI.setEnabled(conLevel["npc1"],false,false);
                  conLevel["mc3"].visible = false;
               }
               else
               {
                  conLevel["mc1"].visible = false;
                  conLevel["mc"].visible = true;
                  conLevel["mc3"].visible = true;
                  CommonUI.setEnabled(conLevel["npc1"],true);
                  CommonUI.setEnabled(conLevel["npc2"],false,false);
               }
               num = int(ItemManager.getNumByID(1717990));
               conLevel["mc"]["num"].text = num;
               LevelManager.openMouseEvent();
               if(fun != null)
               {
                  fun();
               }
               if(num >= 5)
               {
                  conLevel["movie"].visible = true;
                  LevelManager.closeMouseEvent();
                  AnimateManager.playMcAnimate(conLevel["movie"],1,"",function():void
                  {
                     LevelManager.openMouseEvent();
                     KTool.doExchange(11889,function():void
                     {
                        MapManager.changeMapWithCallback(1317,function():void
                        {
                           ModuleManager.showAppModule("XiannvlongMainPanel");
                        });
                     });
                  });
               }
            });
         });
      }
      
      private function onLoad(param1:DisplayObject) : void
      {
         this.npcmc = param1 as MovieClip;
         this.npcmc.scaleX = this.npcmc.scaleY = 1;
         conLevel.addChild(this.npcmc);
         this.setpos();
      }
      
      private function setpos() : void
      {
         var _loc1_:String = null;
         if(this.npcmc)
         {
            this.npcmc.x = MainManager.actorModel.x;
            this.npcmc.y = MainManager.actorModel.y;
            _loc1_ = MainManager.actorModel.direction;
            this.npcmc.gotoAndStop(_loc1_);
         }
      }
      
      private function timerHandle() : void
      {
         if(this.lefttime > 0)
         {
            conLevel["mc2"].visible = true;
            --this.lefttime;
            conLevel["mc2"].gotoAndStop(int(conLevel["mc2"].totalFrames * Number((6 - this.lefttime) / 6)));
            if(this.lefttime <= 0)
            {
               conLevel["mc2"].visible = false;
               LevelManager.openMouseEvent();
               SocketConnection.sendByQueue(45743,[22,2],function(param1:*):void
               {
                  refreshstate();
               });
            }
         }
         else
         {
            conLevel["mc2"].visible = false;
         }
      }
      
      private function npcClick(param1:MouseEvent) : void
      {
         this.curnpc = param1.target;
         MainManager.actorModel.stop();
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         var _loc2_:Point = new Point();
         _loc2_ = MainManager.actorModel.parent.globalToLocal(this.curnpc.localToGlobal(new Point(0,0)));
         MainManager.actorModel.walkAction(_loc2_,false);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
      }
      
      private function onWalkEnter(param1:RobotEvent) : void
      {
         var point:Point = null;
         var evt:RobotEvent = param1;
         this.setpos();
         if(Boolean(MainManager.actorModel.parent) && this.curnpc)
         {
            point = new Point();
            point = MainManager.actorModel.parent.globalToLocal(this.curnpc.localToGlobal(new Point(0,0)));
            if(this.curnpc && Point.distance(point,MainManager.actorModel.pos) < 60)
            {
               MainManager.actorModel.stop();
               switch(this.curnpc)
               {
                  case conLevel["npc1"]:
                     if(this.tasktype == 1)
                     {
                        LevelManager.closeMouseEvent();
                        this.lefttime = 6;
                        this.timerHandle();
                        break;
                     }
                     NpcDialog.show(1519,["此树是我栽，此果是我摘！要想得此果，留下买路财！"],["将其赶跑！","使用钻石砸晕它！","好汉饶命，溜了溜了！"],[function():void
                     {
                        FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
                        {
                           FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                        });
                        FightManager.fightNoMapBoss("",13996);
                     },function():void
                     {
                        KTool.buyProductByCallback(254397,1,function():void
                        {
                           SocketConnection.sendByQueue(45743,[22,3],function(param1:*):void
                           {
                              refreshstate();
                           });
                        });
                     },null],false,null,true);
                     break;
                  case conLevel["npc2"]:
                     if(this.step == 0)
                     {
                        NpcDialog.show(400,["哈喽，你是贝迪吗？我听布鲁和格林提起过你。我想问下这里有寒月光吗？"],["…"],[function():void
                        {
                           NpcDialog.show(2609,["当然，只是现在乌云遮住了月光。我可以使用狂风将乌云吹散，只是…我现在肚子有点饿了，你能去帮我收集5个贝迪果实吗？"],["包在我身上！"],[function():void
                           {
                              SocketConnection.sendByQueue(45743,[22,1],function(param1:*):void
                              {
                                 refreshstate();
                              });
                           }],false,null,true);
                        }],false,null,true);
                     }
               }
               this.curnpc = null;
            }
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var ename:String = e.target.name;
         switch(ename)
         {
            case "close":
               MapManager.changeMap(1317);
               break;
            case "buy":
               KTool.buyProductWithExchange(254396,11888,function():void
               {
                  refreshstate();
               });
               break;
            default:
               if(e.target is SimpleButton)
               {
                  this.npcClick(e);
               }
         }
      }
      
      override public function destroy() : void
      {
         if(this.npcmc)
         {
            if(this.npcmc.parent)
            {
               this.npcmc.parent.removeChild(this.npcmc);
            }
            this.npcmc = null;
         }
         MainManager.actorModel.visible = true;
         ResourceManager.cancelURL(ClientConfig.getPetSwfPath(400));
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         SystemTimerManager.removeTickFun(this.timerHandle);
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

