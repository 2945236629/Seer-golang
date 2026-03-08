package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_11721 extends BaseMapProcess
   {
      
      private var curnpc:*;
      
      private var lefttime:int;
      
      private var npcmc:MovieClip;
      
      public function MapProcess_11721()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapManager.currentMap.root["movie"].visible = false;
         MapManager.currentMap.root["movie"].gotoAndStop(1);
         MainManager.actorModel.hideNono();
         MainManager.actorModel.visible = false;
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         ResourceManager.getResource(ClientConfig.getPetSwfPath(400),this.onLoad,"pet");
         LevelManager.iconLevel.visible = false;
         MapManager.currentMap.backLevel.addEventListener(MouseEvent.CLICK,this.backClick);
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         SystemTimerManager.addTickFun(this.timerHandle);
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
            conLevel["mc"].visible = true;
            --this.lefttime;
            conLevel["mc"]["txt"].text = this.lefttime;
            if(this.lefttime <= 0)
            {
               conLevel["mc"].visible = false;
               LevelManager.root.removeEventListener(MouseEvent.CLICK,this.levelrootClick);
               MapManager.currentMap.root["movie"].visible = false;
               MapManager.currentMap.root["movie"].gotoAndStop(1);
               SocketConnection.sendByQueue(45743,[21,0],function(param1:*):void
               {
                  var e:* = param1;
                  MapManager.changeMapWithCallback(1317,function():void
                  {
                     ModuleManager.showAppModule("XiannvlongMainPanel");
                  });
               });
            }
         }
         else
         {
            MapManager.currentMap.root["movie"].visible = false;
            MapManager.currentMap.root["movie"].gotoAndStop(1);
            conLevel["mc"].visible = false;
         }
      }
      
      private function levelrootClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this.lefttime > 0)
         {
            LevelManager.root.removeEventListener(MouseEvent.CLICK,this.levelrootClick);
            NpcDialog.show(5504,["寒月光正在照耀着你，再坚持一下！"],["好的！"],[function():void
            {
               setTimeout(function():void
               {
                  LevelManager.root.addEventListener(MouseEvent.CLICK,levelrootClick);
               },100);
            }],false,null,true);
         }
         e.stopImmediatePropagation();
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
                  case conLevel["npc2"]:
                     MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
                     MapManager.currentMap.backLevel.removeEventListener(MouseEvent.CLICK,this.backClick);
                     LevelManager.root.removeEventListener(MouseEvent.CLICK,this.levelrootClick);
                     NpcDialog.show(5504,["远方的来客啊，欢迎你来到月影花园，你是来参加我们的宇宙旅行团聚会吗？咦？贝迪跑哪里去了？"],["谢谢你们的好意！"],[function():void
                     {
                        NpcDialog.show(400,["我…我只是想来问问这里有没有寒月光…"],["…"],[function():void
                        {
                           NpcDialog.show(5504,["哈哈哈，你算找对地方了！喏，看到天边那轮弯月了吗？静静地沐浴在月光之下吧！30秒之后你将会感受到寒月光的魅力！"],["好的！"],[function():void
                           {
                              lefttime = 31;
                              timerHandle();
                              MapManager.currentMap.root["movie"].visible = true;
                              MapManager.currentMap.root["movie"].gotoAndPlay(1);
                              setTimeout(function():void
                              {
                                 LevelManager.root.addEventListener(MouseEvent.CLICK,levelrootClick);
                              },100);
                           }],false,null,true);
                        }],false,null,true);
                     }],false,null,true);
               }
               this.curnpc = null;
            }
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "close":
               MapManager.changeMap(1317);
               break;
            default:
               if(param1.target is SimpleButton)
               {
                  this.npcClick(param1);
               }
         }
      }
      
      private function backClick(param1:MouseEvent) : void
      {
         if(this.lefttime <= 0)
         {
            this.curnpc = null;
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
         MapManager.currentMap.backLevel.removeEventListener(MouseEvent.CLICK,this.backClick);
         LevelManager.root.removeEventListener(MouseEvent.CLICK,this.levelrootClick);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         SystemTimerManager.removeTickFun(this.timerHandle);
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

