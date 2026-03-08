package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.task.taskUtils.taskDialog.TaskQuneProcessor;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.event.MCLoadEvent;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.newloader.MCLoader;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcController;
   import com.robot.core.ui.loading.Loading;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import flash.utils.setTimeout;
   
   public class MapProcess_10353 extends BaseMapProcess
   {
      
      public function MapProcess_10353()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.playJuedouKa();
      }
      
      private function playJuedouKa() : void
      {
         var mapMv:MovieClip = null;
         var mcloader:MCLoader = null;
         var d1:Array = null;
         var d1_1:Array = null;
         var d2:Array = null;
         var d3:Array = null;
         var d4:Array = null;
         var taskQuePro:TaskQuneProcessor = null;
         if(TasksManager.getTaskStatus(1776) == TasksManager.COMPLETE)
         {
            return;
         }
         TasksManager.accept(1776);
         mcloader = new MCLoader(ClientConfig.getFullMovie("juedouka"),null,Loading.TITLE_AND_PERCENT,"加载..");
         mcloader.addEventListener(MCLoadEvent.SUCCESS,function(param1:*):void
         {
            mcloader.removeEventListener(MCLoadEvent.SUCCESS,arguments.callee);
            mapMv = mcloader.loader.content["mv"];
            mcloader.loader.unload();
            mcloader.clear();
            taskQuePro.addFullMv(ClientConfig.getFullMovie("active_20130918_7"));
            taskQuePro.addDialog(d1);
            taskQuePro.start();
         });
         mcloader.doLoad();
         d1 = [[NPC.SHIPER,["小赛尔们用精灵打斗，嬉戏玩乐，本没有过错，但是这动静……有点大，我怕赛尔号飞船承受不了啊。"],["恩，如果不加以控制，这可能比海盗的攻击还凶猛！"]],[NPC.SHIPER,["现在精灵实力越来越强，这个问题刻不容缓，对了，你帮我去找一下派特博士，看看，他有什么高见。"],["好的，我现在就去！"]]];
         d1_1 = [[NPC.DOCTOR,["关于精灵大闹船长室，跟精灵性格无关，不过我想到了一点，那个是什么呢，到底是什么呢？"],["看来博士的健忘症又犯了！"]]];
         d2 = [[NPC.KAPAIJUEDOUSHI,["最近我和发明家肖恩一起在研制一个卡牌制造仪，如果这个伟大的发明一旦成功，以后就能轻松造出精灵决斗卡。"],["造出精灵决斗卡？！"]],[NPC.KAPAIJUEDOUSHI,["恩，有了精灵决斗卡，赛尔们可以用卡牌来决斗，可以减少精灵打斗的动静，也不会造成赛尔号的船舱破坏。"],["嗯，貌似船长可以安心思考未来了！"]],[NPC.KAPAIJUEDOUSHI,["不知道肖恩那边进展如何了，应该快完成了吧。"],["我帮你去看看吧！顺便满足一下我的好奇心！"]]];
         d3 = [[NPC.SHAWN,["哈哈，终于完成啦，咦，你是来看我的新发明吗？看好了，只要你的精灵站在这个仪器前，一个闪光，就完成啦！看！"],["这个是？造出精灵决斗卡啦！！"]],[NPC.SHAWN,["嗯哼~这是最新高科技，只要仪器对准精灵，让精灵摆好姿势，按一下按钮，然后就等卡牌自动出来了"],["这么神奇！太给力了！"]],[NPC.SHAWN,["你能不能帮我把这台仪器带给卡牌决斗使，这可是他梦寐以求的东西。"],["好的，我马上带过去！"]]];
         d4 = [[NPC.KAPAIJUEDOUSHI,["啊！肖恩研发的新仪器完成了啊，太好了，以后可以轻松制造精灵决斗卡了。如此一来，精灵决斗卡第五弹即将完成！"],["精灵决斗卡第五弹？！"]],[NPC.KAPAIJUEDOUSHI,["为了表达我的谢意，告诉你一个秘密哦，这次《赛尔号：精灵决斗卡》第五弹不仅有新精灵，还有新玩法哦！"],["太好了，期待第五弹，我还要成为卡牌的决斗高手！"]],[NPC.KAPAIJUEDOUSHI,["哈哈哈，每一个年轻的赛尔都有超越前辈们的潜质！另外船长想惩罚赛小息，我提议让雷蒙教官指派一个特殊任务，让他们用卡牌制造仪去神兽那边，你觉得这点子如何？"],["好！等一下……难道精灵决斗卡第五弹会有神兽登场？！"]],[NPC.KAPAIJUEDOUSHI,["这个是秘密啦~允许我卖一下关子先！"],["好吧，我一定要得到卡牌中的神兽！！"]]];
         taskQuePro = new TaskQuneProcessor();
         taskQuePro.procesEndFun = function():void
         {
            NpcController.npcVisible = true;
            taskQuePro.destory();
            KTool.changeMapWithCallBack(5,function():void
            {
               setTimeout(function():void
               {
                  getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(false);
               },100);
               NpcController.npcVisible = false;
               KTool.hideMapAllPlayerAndMonster();
               MapManager.currentMap.topLevel.addChild(mapMv);
               taskQuePro = new TaskQuneProcessor();
               taskQuePro.addDialog(d1_1);
               taskQuePro.addMapMv(mapMv);
               taskQuePro.addDialog(d2);
               taskQuePro.start();
               taskQuePro.procesEndFun = function():void
               {
                  KTool.changeMapWithCallBack(107,function():void
                  {
                     taskQuePro = new TaskQuneProcessor();
                     taskQuePro.addDialog(d3);
                     taskQuePro.start();
                     taskQuePro.procesEndFun = function():void
                     {
                        KTool.changeMapWithCallBack(37,function():void
                        {
                           taskQuePro.destory();
                           taskQuePro = new TaskQuneProcessor();
                           taskQuePro.addDialog(d4);
                           taskQuePro.start();
                           taskQuePro.procesEndFun = function():void
                           {
                              TasksManager.complete(1776,0);
                           };
                        });
                     };
                  });
               };
            });
         };
      }
   }
}

